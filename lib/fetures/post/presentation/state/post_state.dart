

import '../../domain/entity/post_entity.dart';

class PostState {
  final bool isLoading;
  final List<PostEntity> posts;
  final List<PostEntity> postById;
  final String? error;
  final String? imageName;

  PostState({
    required this.isLoading,
    required this.posts,
    required this.postById,
    this.error,
    this.imageName,
  });

  factory PostState.initial() {
    return PostState(
      isLoading: false,
      posts: [],
      postById: [],
      error: null,
      imageName: null,
    );
  }

  PostState copyWith({
    bool? isLoading,
    List<PostEntity>? posts,
    List<PostEntity>? postsById,
    String? error,
    String? imageName,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      postById: postById ?? this.postById,
      posts: posts ?? this.posts,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
