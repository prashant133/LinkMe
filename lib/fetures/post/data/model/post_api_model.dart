

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
 
  
  final String description;
  
  final String? image;
  final String user;

  const PostApiModel({
    required this.id,
    
    
    required this.description,
    
    required this.user,
    this.image,
  });

  const PostApiModel.empty()
      : id = '',
        
        description = '',
       
        image = '',
        user = '';

  // convert API object to Entity
  PostEntity toEntity() => PostEntity(
        postId: id,
       
        description: description,
       
        image: image,
        user: user,
      );

  // convert Entity to API object
  PostApiModel fromEntity(PostEntity entity) => PostApiModel(
        id: entity.postId!,
        
        
        description: description,
        
        
        image: image,
        user: user,
      );

  // convert API list to Entity list
  List<PostEntity> toEntityList(List<PostApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        
        description,
        
        image,
      ];

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostApiModelToJson(this);
}
