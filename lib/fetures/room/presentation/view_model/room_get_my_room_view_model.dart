import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';
import 'package:room_finder_app/fetures/room/domain/use_case/room_usecase.dart';
import 'package:room_finder_app/fetures/room/presentation/state/room_state.dart';

import '../../../../core/common/snackbar/snackbar.dart';

final roomGetMyRoomViewModelProvider =
    StateNotifierProvider<RoomGetMyRoomViewModel, RoomState>(
  (ref) => RoomGetMyRoomViewModel(
    ref.watch(roomUsecaseProvider),
  ),
);

class RoomGetMyRoomViewModel extends StateNotifier<RoomState> {
  final RoomUseCase roomUseCase;

  RoomGetMyRoomViewModel(this.roomUseCase) : super(RoomState.initial()) {
    getMyRooms();
  }

  Future<void> getMyRooms() async {
    state = state.copyWith(isLoading: true);
    var data = await roomUseCase.getMyRooms();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, rooms: r, error: null),
    );
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

//   deleteRoom(String roomId) async {
//     state = state.copyWith(isLoading: true);
//     var data = await roomUseCase.deleteRoom(roomId);
//     state = state.copyWith(isLoading: false);

//     data.fold(
//       (l) => state = state.copyWith(isLoading: false, error: l.error),
//       (r) {
//         // If the room is deleted successfully, remove it from the list in the state.
//         state = state.copyWith(
//           isLoading: false,
//           error: null,
//           rooms: state.rooms.where((room) => room.roomId != roomId).toList(),
//         );
//       },
//     );
//   }
  Future<void> deleteRoom(BuildContext context, String roomId) async {
    state.copyWith(isLoading: true);
    var data = await roomUseCase.deleteRoom(roomId);
    print("the room id  is $roomId");

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Room delete successfully',
          context: context,
        );
      },
    );
  }
}
