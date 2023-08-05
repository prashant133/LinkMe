// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_room_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllRoomsDTO _$GetAllRoomsDTOFromJson(Map<String, dynamic> json) =>
    GetAllRoomsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => RoomApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllRoomsDTOToJson(GetAllRoomsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
