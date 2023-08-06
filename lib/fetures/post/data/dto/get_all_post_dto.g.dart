// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPostsDTO _$GetAllPostsDTOFromJson(Map<String, dynamic> json) =>
    GetAllPostsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PostApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPostsDTOToJson(GetAllPostsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
