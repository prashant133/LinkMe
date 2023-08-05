import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/failure/failure.dart';
import 'package:room_finder_app/fetures/room/data/data_source/room_remote_data_source.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';

import '../../domain/repository/room_repositary.dart';

final roomRemoteRepositoryProvider = Provider<IRoomRepository>((ref) {
  return RoomRemoteRepository(
    ref.read(roomRemoteDataSourceProvider),
  );
});

class RoomRemoteRepository implements IRoomRepository {
  final RoomRemoteDataSource _roomRemoteDataSource;

  RoomRemoteRepository(this._roomRemoteDataSource);

  @override
  Future<Either<Failure, bool>> addRooms(RoomEntity room) {
    return _roomRemoteDataSource.addRooms(room);
  }
  @override
  Future<Either<Failure, bool>> deleteRoom(String roomId ) {
    return _roomRemoteDataSource.deleteRoom( roomId);
  }

  @override
  Future<Either<Failure, List<RoomEntity>>> getAllRooms() {
    return _roomRemoteDataSource.getAllRooms();
  }
  @override
  Future<Either<Failure, List<RoomEntity>>> getMyRooms() {
    return _roomRemoteDataSource.getMyRooms();
  }

  @override
  Future<Either<Failure, String>> uploadRoomPicture(File file, String postId) {
    return _roomRemoteDataSource.uploadRoomPicture(file, postId);
  }

  

  @override
  Future<Either<Failure, List<RoomEntity>>> getRoomById(String roomId) {
    return _roomRemoteDataSource.getRoomById(roomId);
  }

  @override
  Future<Either<Failure, bool>> updateRoom(RoomEntity room, String roomId) {
    return _roomRemoteDataSource.updateBook(room, roomId);
  }
}
