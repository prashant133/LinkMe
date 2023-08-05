import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/failure/failure.dart';
import 'package:room_finder_app/fetures/room/data/dto/get_all_room_dto.dart';
import 'package:room_finder_app/fetures/room/data/model/room_api_model.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';

import '../../../../config/constants/api_endipoint.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../dto/get_my_rooms_dto.dart';
import '../dto/get_room_by_id_dto.dart';

final roomRemoteDataSourceProvider = Provider(
  (ref) => RoomRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    roomApiModel: ref.read(roomApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class RoomRemoteDataSource {
  late final Dio dio;
  late final RoomApiModel roomApiModel;
  late final UserSharedPrefs userSharedPrefs;

  RoomRemoteDataSource({
    required this.dio,
    required this.roomApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addRooms(RoomEntity room) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.post(
        ApiEndpoints.addRooms,
        data: {
          "title": room.title,
          "location": room.location,
          "description": room.description,
          "phoneNumber": room.phoneNumber,
          "price": room.price,
          "image": room.image,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        // save the post id
        RoomEntity.postId = response.data['id'];

        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  Future<Either<Failure, List<RoomEntity>>> getAllRooms() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.get(
        ApiEndpoints.getAllRooms,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetAllRoomsDTO roomsDto = GetAllRoomsDTO.fromJson(response.data);

        return Right(roomApiModel.toEntityList(roomsDto.data));
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadRoomPicture(
    File image,
    String postId,
  ) async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'RoomImages': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage + postId,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateBook(
      RoomEntity room, String roomId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updateRoom(roomId),
        data: {
          "title": room.title,
          "price": room.price,
          "description": room.description,
          "location": room.location,
          "image": room.image,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 204) {
        // Profile edited successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: 'Failed to update Room. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteRoom(String roomId) async {
    try {
      String? token;

      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
     

      var response = await dio.delete(
        ApiEndpoints.deleteRoom(roomId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // var response = http.delete(Uri.parse(ApiEndpoints.baseUrl+ ''))

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['error'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<RoomEntity>>> getRoomById(String roomId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getRoomById(roomId),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetRoomByIdDTO roomAddDTO = GetRoomByIdDTO.fromJson(response.data);
        return Right(roomApiModel.toEntityList(roomAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<RoomEntity>>> getMyRooms() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.get(
        ApiEndpoints.getMyRooms,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetMyRoomsDTO roomsDto = GetMyRoomsDTO.fromJson(response.data);

        return Right(roomApiModel.toEntityList(roomsDto.data));
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }
}
