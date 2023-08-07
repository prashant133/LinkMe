import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/post_entity.dart';
import '../view_model/post_viewmodel.dart';

class AddPosts extends ConsumerStatefulWidget {
  const AddPosts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostsState();
}

class _AddPostsState extends ConsumerState<AddPosts> {
  final _descrpitionController = TextEditingController();

  @override
  void dispose() {
    _descrpitionController.dispose();

    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postViewModelProvider);
    double width = MediaQuery.of(context).size.width;
    const gap = SizedBox(
      height: 10,
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                gap,
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      gap,
                      TextFormField(
                        controller: _descrpitionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write the descrpition of the post';
                          }
                          return null;
                        },
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Descrpition",
                          hintText: "Write descrptions about the post",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      gap,
                      Container(
                        width: width * 0.55,
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              PostEntity post = PostEntity(
                                description: _descrpitionController.text,
                                user: '',
                              );
                              ref
                                  .read(postViewModelProvider.notifier)
                                  .addPosts(post, context);
                            }
                            if (postState.error != null) {
                              showSnackBar(
                                context: context,
                                message: postState.error.toString(),
                              );
                            } else {
                              showSnackBar(
                                context: context,
                                message: 'Added Post Descpriotions',
                                color: Colors.green,
                              );
                            }
                          },
                          child: const Text('Upload Image'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
