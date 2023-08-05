

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/use_case/post_usecase.dart';
import '../state/post_state.dart';

final postViewModelProvider = StateNotifierProvider<PostViewModel, PostState>(
  (ref) => PostViewModel(
    ref.watch(postUsecaseProvider),
  ),
);

class PostViewModel extends StateNotifier<PostState> {
  final PostUseCase postUseCase;

  PostViewModel(this.postUseCase) : super(PostState.initial()) {
    getAllPosts();
    
  }

  Future<void> getAllPosts() async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.getAllPosts();
    

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, posts: r, error: null),
    );
  }

  Future<void> getMyPosts() async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.getMyPosts();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, posts: r, error: null),
    );
  }

  Future<void> addPosts(PostEntity postEntity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.addPosts(postEntity);
    data.fold((failed) {
      state = state.copyWith(isLoading: false, error: failed.error);
    }, (success) {
      state = state.copyWith(isLoading: false, error: null);

      // navigate to sign in view
      Navigator.pushNamed(context, AppRoute.uploadViews);
    });
  }

  updatePost(PostEntity post, String postId) async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.updatePost(post, postId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }


  getPostById(String postId) async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.getPostById(postId);
    state = state.copyWith(postsById: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, postsById: r, error: null),
    );
  }

  Future<void> uploadImage(File file, String postId2) async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.uploadPostPicture(file, postId2);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }
}
