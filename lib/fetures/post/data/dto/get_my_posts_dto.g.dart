// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_posts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyPostsDTO _$GetMyPostsDTOFromJson(Map<String, dynamic> json) =>
    GetMyPostsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PostApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyPostsDTOToJson(GetMyPostsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
