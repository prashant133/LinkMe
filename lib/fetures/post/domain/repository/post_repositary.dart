

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/Provider/internet_connection.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/post_remote_repository.dart';
import '../entity/post_entity.dart';

final postRepositoryProvider = Provider<IPostRepository>((ref) {
  // ignore: unused_local_variable
  final internetStatus = ref.watch(connectivityStatusProvider);

  return ref.watch(postRemoteRepositoryProvider);
});

abstract class IPostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, List<PostEntity>>> getMyPosts();
  Future<Either<Failure, List<PostEntity>>> getPostById(String postId);
  Future<Either<Failure, bool>> addPosts(PostEntity post);
  
  Future<Either<Failure, bool>> updatePost(PostEntity post, String postId);
  Future<Either<Failure, bool>> deletePost( String postId);
  Future<Either<Failure, String>> uploadPostPicture(File file, String postId2);
  
}
