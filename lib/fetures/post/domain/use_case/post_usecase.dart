

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repositary.dart';

final postUsecaseProvider = Provider<PostUseCase>(
  (ref) => PostUseCase(
    ref.watch(postRepositoryProvider),
  ),
);

class PostUseCase {
  final IPostRepository _postRepository;

  PostUseCase(this._postRepository);

  Future<Either<Failure, List<PostEntity>>> getAllPosts() {
    return _postRepository.getAllPosts();
  }
  Future<Either<Failure, List<PostEntity>>> getMyPosts() {
    return _postRepository.getMyPosts();
  }
  
  Future<Either<Failure, List<PostEntity>>> getPostById(String postId) {
    return _postRepository.getPostById(postId);
  }

  Future<Either<Failure, bool>> addPosts(PostEntity post) {
    return _postRepository.addPosts(post);
  }
  Future<Either<Failure, bool>> updatePost(PostEntity post, String postId) {
    return _postRepository.updatePost(post, postId);
  }
  Future<Either<Failure, bool>> deletePost( String postId) {
    return _postRepository.deletePost(postId);
  }

  Future<Either<Failure, String>> uploadPostPicture(
      File file, String postId2) async {
    return await _postRepository.uploadPostPicture(file, postId2);
  }
}
