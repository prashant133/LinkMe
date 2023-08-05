import 'package:json_annotation/json_annotation.dart';

import '../model/post_api_model.dart';


part 'get_all_post_dto.g.dart';

@JsonSerializable()
class GetAllPostsDTO {
  final List<PostApiModel> data;

  GetAllPostsDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllPostsDTOToJson(this);

  factory GetAllPostsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPostsDTOFromJson(json);
}
