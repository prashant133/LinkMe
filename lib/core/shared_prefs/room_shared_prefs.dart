import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fetures/post/domain/entity/post_entity.dart';

import '../failure/failure.dart';

class RoomSharedPrefs {
  late SharedPreferences _sharedPreferences;

  //set postentity
  Future<Either<Failure, bool>> setPostEntity(PostEntity post) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Convert UserEntity to JSON string
      final postJson = json.encode(post.toJson());

      // Set the user JSON string in SharedPreferences
      await _sharedPreferences.setString('post', postJson);

      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // get post entity

  Future<Either<Failure, PostEntity?>> gePostEntity() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Get the user JSON string from SharedPreferences
      final postJson = _sharedPreferences.getString('post');

      if (postJson != null) {
        // Parse the JSON string and create a UserEntity object
        final postMap = json.decode(postJson);
        final post = PostEntity.fromJson(postMap);
        return right(post);
      } else {
        return right(null);
      }
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
