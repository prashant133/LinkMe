import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/room_repositary.dart';

final roomUsecaseProvider = Provider<RoomUseCase>(
  (ref) => RoomUseCase(
    ref.watch(roomRepositoryProvider),
  ),
);

class RoomUseCase {
  final IRoomRepository _roomRepository;

  RoomUseCase(this._roomRepository);

  Future<Either<Failure, List<RoomEntity>>> getAllRooms() {
    return _roomRepository.getAllRooms();
  }
  Future<Either<Failure, List<RoomEntity>>> getMyRooms() {
    return _roomRepository.getMyRooms();
  }
  
  Future<Either<Failure, List<RoomEntity>>> getRoomById(String roomId) {
    return _roomRepository.getRoomById(roomId);
  }

  Future<Either<Failure, bool>> addRooms(RoomEntity room) {
    return _roomRepository.addRooms(room);
  }
  Future<Either<Failure, bool>> updateRoom(RoomEntity room, String roomId) {
    return _roomRepository.updateRoom(room, roomId);
  }
  Future<Either<Failure, bool>> deleteRoom( String roomId) {
    return _roomRepository.deleteRoom(roomId);
  }

  Future<Either<Failure, String>> uploadRoomPicture(
      File file, String postId) async {
    return await _roomRepository.uploadRoomPicture(file, postId);
  }
}
