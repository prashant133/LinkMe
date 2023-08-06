import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? postId;
  final String title;
  final String location;
  final String description;
  final int phoneNumber;
  final int price;
  final String? image;
  final String user;

  const PostEntity({
    this.postId,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.phoneNumber,
    this.image,
    required this.user,
  });

  static String postId2 = '';

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        postId: json['postId'],
        title: json['title'],
        location: json['location'],
        description: json['description'],
        phoneNumber: json['phoneNumber'],
        price: json['price'],
        image: json['image'],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "title": title,
        "location": location,
        "description": description,
        "phoneNumber": phoneNumber,
        "price": price,
        'image': image,
        "user": user,
      };

  @override
  List<Object?> get props => [
        postId,
        title,
        location,
        phoneNumber,
        description,
        price,
        image,
        user,
      ];
}
