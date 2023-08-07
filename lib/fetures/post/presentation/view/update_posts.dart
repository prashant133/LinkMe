


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
  
  late TextEditingController _descriptionController;


  @override
  void initState() {
   
    _descriptionController =
        TextEditingController(text: widget.post.description);
    
   
    
    super.initState();
  }

  @override
  void dispose() {
    
    _descriptionController.dispose();
    
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
                            
                            description: _descriptionController.text,
                          
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
