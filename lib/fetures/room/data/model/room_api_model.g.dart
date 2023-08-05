// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomApiModel _$RoomApiModelFromJson(Map<String, dynamic> json) => RoomApiModel(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as int,
      title: json['title'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      user: json['user'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$RoomApiModelToJson(RoomApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'price': instance.price,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'user': instance.user,
    };
