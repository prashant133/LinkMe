

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repositary.dart';
import '../data_source/post_remote_data_source.dart';

final postRemoteRepositoryProvider = Provider<IPostRepository>((ref) {
  return PostRemoteRepository(
    ref.read(postRemoteDataSourceProvider),
  );
});

class PostRemoteRepository implements IPostRepository {
  final PostRemoteDataSource _postRemoteDataSource;

  PostRemoteRepository(this._postRemoteDataSource);

  @override
  Future<Either<Failure, bool>> addPosts(PostEntity post) {
    return _postRemoteDataSource.addPosts(post);
  }
  @override
  Future<Either<Failure, bool>> deletePost(String postId ) {
    return _postRemoteDataSource.deletePost( postId);
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() {
    return _postRemoteDataSource.getAllPosts();
  }
  @override
  Future<Either<Failure, List<PostEntity>>> getMyPosts() {
    return _postRemoteDataSource.getMyPosts();
  }

  @override
  Future<Either<Failure, String>> uploadPostPicture(File file, String postId2) {
    return _postRemoteDataSource.uploadPostPicture(file, postId2);
  }

  

  @override
  Future<Either<Failure, List<PostEntity>>> getPostById(String postId) {
    return _postRemoteDataSource.getPostById(postId);
  }

  @override
  Future<Either<Failure, bool>> updatePost(PostEntity post, String postId) {
    return _postRemoteDataSource.updateBook(post, postId);
  }
  

}
