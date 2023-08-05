import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/use_case/post_usecase.dart';
import '../state/post_state.dart';

final postGetMyPostViewModelProvider =
    StateNotifierProvider<PostGetMyPostViewModel, PostState>(
  (ref) => PostGetMyPostViewModel(
    ref.watch(postUsecaseProvider),
  ),
);

class PostGetMyPostViewModel extends StateNotifier<PostState> {
  final PostUseCase postUseCase;

  PostGetMyPostViewModel(this.postUseCase) : super(PostState.initial()) {
    getMyPosts();
  }

  Future<void> getMyPosts() async {
    state = state.copyWith(isLoading: true);
    var data = await postUseCase.getMyPosts();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, posts: r, error: null),
    );
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

  Future<void> deletePost(BuildContext context, String postId) async {
    state.copyWith(isLoading: true);
    var data = await postUseCase.deletePost(postId);
    

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Post delete successfully',
          context: context,
        );
      },
    );
  }
}
