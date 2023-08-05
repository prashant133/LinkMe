import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';

class RoomState {
  final bool isLoading;
  final List<RoomEntity> rooms;
  final List<RoomEntity> roomById;
  final String? error;
  final String? imageName;

  RoomState({
    required this.isLoading,
    required this.rooms,
    required this.roomById,
    this.error,
    this.imageName,
  });

  factory RoomState.initial() {
    return RoomState(
      isLoading: false,
      rooms: [],
      roomById: [],
      error: null,
      imageName: null,
    );
  }

  RoomState copyWith({
    bool? isLoading,
    List<RoomEntity>? rooms,
    List<RoomEntity>? roomById,
    String? error,
    String? imageName,
  }) {
    return RoomState(
      isLoading: isLoading ?? this.isLoading,
      roomById: roomById ?? this.roomById,
      rooms: rooms ?? this.rooms,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
