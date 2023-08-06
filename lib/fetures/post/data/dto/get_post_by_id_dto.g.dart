// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostByIdDTO _$GetPostByIdDTOFromJson(Map<String, dynamic> json) =>
    GetPostByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PostApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPostByIdDTOToJson(GetPostByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
