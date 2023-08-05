import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_app/fetures/room/data/model/room_api_model.dart';

part 'get_all_room_dto.g.dart';

@JsonSerializable()
class GetAllRoomsDTO {
  final List<RoomApiModel> data;

  GetAllRoomsDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllRoomsDTOToJson(this);

  factory GetAllRoomsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllRoomsDTOFromJson(json);
}
