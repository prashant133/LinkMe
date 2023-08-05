import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/failure/failure.dart';
import 'package:room_finder_app/fetures/room/data/repository/room_remote_repository.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';

import '../../../../core/common/Provider/internet_connection.dart';

final roomRepositoryProvider = Provider<IRoomRepository>((ref) {
  // ignore: unused_local_variable
  final internetStatus = ref.watch(connectivityStatusProvider);

  return ref.watch(roomRemoteRepositoryProvider);
});

abstract class IRoomRepository {
  Future<Either<Failure, List<RoomEntity>>> getAllRooms();
  Future<Either<Failure, List<RoomEntity>>> getMyRooms();
  Future<Either<Failure, List<RoomEntity>>> getRoomById(String roomId);
  Future<Either<Failure, bool>> addRooms(RoomEntity room);
  
  Future<Either<Failure, bool>> updateRoom(RoomEntity room, String roomId);
  Future<Either<Failure, bool>> deleteRoom( String roomId);
  Future<Either<Failure, String>> uploadRoomPicture(File file, String postId);
  
}
