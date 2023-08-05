import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';

part 'room_api_model.g.dart';

final roomApiModelProvider = Provider<RoomApiModel>((ref) {
  return const RoomApiModel.empty();
});

@JsonSerializable()
class RoomApiModel extends Equatable {
  // @JsonKey(name: 'id')
  // final String? roomId;
  final String id;
  final String title;
  final String location;
  final int price;
  final String description;
  final int phoneNumber;
  final String? image;
  final String user;

  const RoomApiModel({
    required this.id,
    required this.phoneNumber,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.user,
    this.image,
  });

  const RoomApiModel.empty()
      : id = '',
        title = '',
        location = '',
        description = '',
        phoneNumber = 0,
        price = 0,
        image = '',
        user = '';

  // convert API object to Entity
  RoomEntity toEntity() => RoomEntity(
        roomId: id,
        title: title,
        phoneNumber: phoneNumber,
        location: location,
        description: description,
        price: price,
        image: image,
        user: user,
      );

  // convert Entity to API object
  RoomApiModel fromEntity(RoomEntity entity) => RoomApiModel(
        id: entity.roomId!,
        title: title,
        location: location,
        description: description,
        phoneNumber: phoneNumber,
        price: price,
        image: image,
        user: user,
      );

  // convert API list to Entity list
  List<RoomEntity> toEntityList(List<RoomApiModel> models) =>
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

  factory RoomApiModel.fromJson(Map<String, dynamic> json) =>
      _$RoomApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomApiModelToJson(this);
}
