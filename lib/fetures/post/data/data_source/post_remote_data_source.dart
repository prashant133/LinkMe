

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../config/constants/api_endipoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';

import '../../domain/entity/post_entity.dart';
import '../dto/get_all_post_dto.dart';
import '../dto/get_my_posts_dto.dart';
import '../dto/get_post_by_id_dto.dart';
import '../model/post_api_model.dart';

final postRemoteDataSourceProvider = Provider(
  (ref) => PostRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    postApiModel: ref.read(postApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class PostRemoteDataSource {
  late final Dio dio;
  late final PostApiModel postApiModel;
  late final UserSharedPrefs userSharedPrefs;

  PostRemoteDataSource({
    required this.dio,
    required this.postApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addPosts(PostEntity post) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.post(
        ApiEndpoints.addPosts,
        data: {
          
          "description": post.description,
          
          "image": post.image,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        // save the post id
        PostEntity.postId2 = response.data['id'];

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

  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.get(
        ApiEndpoints.getAllPosts,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetAllPostsDTO postsDTO = GetAllPostsDTO.fromJson(response.data);

        return Right(postApiModel.toEntityList(postsDTO.data));
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
  Future<Either<Failure, String>> uploadPostPicture(
    File image,
    String postId2,
  ) async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'PostImages': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage + postId2,
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
      PostEntity post, String postId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updatePost(postId),
        data: {
          
          "description": post.description,
          
          "image": post.image,
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
            error: 'Failed to update Post. Please try again.',
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

  Future<Either<Failure, bool>> deletePost(String postId) async {
    try {
      String? token;

      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
     

      var response = await dio.delete(
        ApiEndpoints.deletePost(postId),
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

  Future<Either<Failure, List<PostEntity>>> getPostById(String postId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getPostById(postId),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetPostByIdDTO postAddDTO = GetPostByIdDTO.fromJson(response.data);
        return Right(postApiModel.toEntityList(postAddDTO.data));
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

  Future<Either<Failure, List<PostEntity>>> getMyPosts() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.get(
        ApiEndpoints.getMyPosts,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetMyPostsDTO postsDto = GetMyPostsDTO.fromJson(response.data);

        return Right(postApiModel.toEntityList(postsDto.data));
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
