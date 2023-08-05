import 'package:json_annotation/json_annotation.dart';

import '../model/post_api_model.dart';



part 'get_post_by_id_dto.g.dart';

@JsonSerializable()
class GetPostByIdDTO {
  final List<PostApiModel> data;

  GetPostByIdDTO({
    required this.data,
  });

  factory GetPostByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetPostByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostByIdDTOToJson(this);
}
