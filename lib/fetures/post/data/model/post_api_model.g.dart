// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) => PostApiModel(
      id: json['id'] as String,
     
     
      description: json['description'] as String,
      
      user: json['user'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PostApiModelToJson(PostApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      
      'description': instance.description,
      
      'image': instance.image,
      'user': instance.user,
    };
