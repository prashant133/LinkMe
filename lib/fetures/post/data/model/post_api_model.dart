

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/post_entity.dart';

part 'post_api_model.g.dart';

final postApiModelProvider = Provider<PostApiModel>((ref) {
  return const PostApiModel.empty();
});

@JsonSerializable()
class PostApiModel extends Equatable {

  final String id;
  final String title;
  final String location;
  final int price;
  final String description;
  final int phoneNumber;
  final String? image;
  final String user;

  const PostApiModel({
    required this.id,
    required this.phoneNumber,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.user,
    this.image,
  });

  const PostApiModel.empty()
      : id = '',
        title = '',
        location = '',
        description = '',
        phoneNumber = 0,
        price = 0,
        image = '',
        user = '';

  // convert API object to Entity
  PostEntity toEntity() => PostEntity(
        postId: id,
        title: title,
        phoneNumber: phoneNumber,
        location: location,
        description: description,
        price: price,
        image: image,
        user: user,
      );

  // convert Entity to API object
  PostApiModel fromEntity(PostEntity entity) => PostApiModel(
        id: entity.postId!,
        title: title,
        location: location,
        description: description,
        phoneNumber: phoneNumber,
        price: price,
        image: image,
        user: user,
      );

  // convert API list to Entity list
  List<PostEntity> toEntityList(List<PostApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        phoneNumber,
        description,
        price,
        image,
      ];

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostApiModelToJson(this);
}
