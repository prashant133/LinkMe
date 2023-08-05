import 'package:json_annotation/json_annotation.dart';

import '../model/post_api_model.dart';


part 'get_my_posts_dto.g.dart';

@JsonSerializable()
class GetMyPostsDTO {
  final List<PostApiModel> data;

  GetMyPostsDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetMyPostsDTOToJson(this);

  factory GetMyPostsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetMyPostsDTOFromJson(json);
}