// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_rooms_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyRoomsDTO _$GetMyRoomsDTOFromJson(Map<String, dynamic> json) =>
    GetMyRoomsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => RoomApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyRoomsDTOToJson(GetMyRoomsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
