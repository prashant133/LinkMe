


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/post_entity.dart';
import '../view_model/post_get_my_post__view_model.dart';


class UpdateView extends ConsumerStatefulWidget {
  const UpdateView({super.key, required this.post});
  final PostEntity post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadViewState();
}

class _UploadViewState extends ConsumerState<UpdateView> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _locationController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController =
        TextEditingController(text: widget.post.description);
    _locationController = TextEditingController(text: widget.post.location);
    _phoneNumberController =
        TextEditingController(text: widget.post.phoneNumber.toString());
    _priceController =
        TextEditingController(text: widget.post.price.toString());
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _phoneNumberController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  final _key = GlobalKey<FormState>();
  final gap = const SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Post"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  gap,
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      hintText: "Write the title of the Post",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please insert the title of the post";
                      }
                      return null;
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
                      hintText: "Enter the location of the post",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the location of a Post";
                      }
                      return null;
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      hintText: "Enter the Price of the posts",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please give the price of the posts";
                      }
                      return null;
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      hintText: "write your phone number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Write your Phone Number";
                      }
                      return null;
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Write description of the post",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please write the description of the post";
                      }
                      return null;
                    },
                  ),
                  gap,
                  ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          PostEntity post = PostEntity(
                            title: _titleController.text,
                            location: _locationController.text,
                            description: _descriptionController.text,
                            price: int.parse(_priceController.text),
                            phoneNumber: int.parse(_phoneNumberController.text),
                            user: '',
                          );
                          ref
                              .watch(postGetMyPostViewModelProvider.notifier)
                              .updatePost(post, widget.post.postId!);
                          ref
                              .watch(postGetMyPostViewModelProvider.notifier)
                              .getMyPosts()
                              .then((value) {
                            Navigator.pop(context);
                            showSnackBar(
                              context: context,
                              message: "Post updated successfully",
                              color: Colors.green,
                            );
                          });
                        }
                      },
                      child: const Text('Update Post'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
