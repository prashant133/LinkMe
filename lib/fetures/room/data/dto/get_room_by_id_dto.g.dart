// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_room_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoomByIdDTO _$GetRoomByIdDTOFromJson(Map<String, dynamic> json) =>
    GetRoomByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => RoomApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRoomByIdDTOToJson(GetRoomByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
