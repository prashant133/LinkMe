import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_app/fetures/room/data/model/room_api_model.dart';


part 'get_room_by_id_dto.g.dart';

@JsonSerializable()
class GetRoomByIdDTO {
  final List<RoomApiModel> data;

  GetRoomByIdDTO({
    required this.data,
  });

  factory GetRoomByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetRoomByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoomByIdDTOToJson(this);
}
