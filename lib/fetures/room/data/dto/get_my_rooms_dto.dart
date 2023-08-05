import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_app/fetures/room/data/model/room_api_model.dart';

part 'get_my_rooms_dto.g.dart';

@JsonSerializable()
class GetMyRoomsDTO {
  final List<RoomApiModel> data;

  GetMyRoomsDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetMyRoomsDTOToJson(this);

  factory GetMyRoomsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetMyRoomsDTOFromJson(json);
}