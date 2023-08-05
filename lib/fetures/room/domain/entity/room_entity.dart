import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final String? roomId;
  final String title;
  final String location;
  final String description;
  final int phoneNumber;
  final int price;
  final String? image;
  final String user;

  const RoomEntity({
    this.roomId,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.phoneNumber,
    this.image,
    required this.user,
  });

  static String postId = '';

  factory RoomEntity.fromJson(Map<String, dynamic> json) => RoomEntity(
        roomId: json['roomId'],
        title: json['title'],
        location: json['location'],
        description: json['description'],
        phoneNumber: json['phoneNumber'],
        price: json['price'],
        image: json['image'],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
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
        roomId,
        title,
        location,
        phoneNumber,
        description,
        price,
        image,
        user,
      ];
}
