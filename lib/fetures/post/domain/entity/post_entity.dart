import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;

  final String description;

  final String? image;
  final String user;

  const PostEntity({
    this.postId,
    required this.description,
    this.image,
    required this.user,
  });

  static String postId2 = '';

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        postId: json['postId'],
        description: json['description'],
        image: json['image'],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "description": description,
        'image': image,
        "user": user,
      };

  @override
  List<Object?> get props => [
        postId,
        description,
        image,
        user,
      ];
}
