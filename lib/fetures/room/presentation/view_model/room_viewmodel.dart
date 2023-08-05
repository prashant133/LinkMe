import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';
import 'package:room_finder_app/fetures/room/domain/use_case/room_usecase.dart';
import 'package:room_finder_app/fetures/room/presentation/state/room_state.dart';

import '../../../../config/router/app_route.dart';

final roomViewModelProvider = StateNotifierProvider<RoomViewModel, RoomState>(
  (ref) => RoomViewModel(
    ref.watch(roomUsecaseProvider),
  ),
);

class RoomViewModel extends StateNotifier<RoomState> {
  final RoomUseCase roomUseCase;

  RoomViewModel(this.roomUseCase) : super(RoomState.initial()) {
    getAllRooms();
    // getMyRooms();
  }

  Future<void> getAllRooms() async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.getAllRooms();
    // state = state.copyWith(rooms: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, rooms: r, error: null),
    );
  }

  Future<void> getMyRooms() async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.getMyRooms();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, rooms: r, error: null),
    );
  }

  Future<void> addRooms(RoomEntity roomEntity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.addRooms(roomEntity);
    data.fold((failed) {
      state = state.copyWith(isLoading: false, error: failed.error);
    }, (success) {
      state = state.copyWith(isLoading: false, error: null);

      // navigate to sign in view
      Navigator.pushNamed(context, AppRoute.uploadViews);
    });
  }

  updateRoom(RoomEntity room, String roomId) async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.updateRoom(room, roomId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }


  getRoomById(String roomId) async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.getRoomById(roomId);
    state = state.copyWith(roomById: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, roomById: r, error: null),
    );
  }

  Future<void> uploadImage(File file, String postId) async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.uploadRoomPicture(file, postId);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }
}
