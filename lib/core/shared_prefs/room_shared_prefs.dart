import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fetures/room/domain/entity/room_entity.dart';
import '../failure/failure.dart';

class RoomSharedPrefs {
  late SharedPreferences _sharedPreferences;

  //set roomentity
  Future<Either<Failure, bool>> setRoomEntity(RoomEntity room) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Convert UserEntity to JSON string
      final roomJson = json.encode(room.toJson());

      // Set the user JSON string in SharedPreferences
      await _sharedPreferences.setString('room', roomJson);

      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // get room entity

  Future<Either<Failure, RoomEntity?>> geRoomEntity() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Get the user JSON string from SharedPreferences
      final roomJson = _sharedPreferences.getString('room');

      if (roomJson != null) {
        // Parse the JSON string and create a UserEntity object
        final roomMap = json.decode(roomJson);
        final room = RoomEntity.fromJson(roomMap);
        return right(room);
      } else {
        return right(null);
      }
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
