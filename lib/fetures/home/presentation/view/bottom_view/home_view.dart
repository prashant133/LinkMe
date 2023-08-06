

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/text/post_style_text.dart';
import '../../../../auth/presentation/state/auth_state.dart';
import '../../../../post/domain/entity/post_entity.dart';
import '../../../../post/presentation/view_model/post_viewmodel.dart';



class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postViewModelProvider);

    final List<PostEntity> postList = postState.posts;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: width, // Adjust width as needed
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(
                          255, 186, 181, 235), // Greyish background color
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30)),
                            child: CircleAvatar(
                              radius: height * 0.0758,
                              backgroundImage: const AssetImage(
                                'assets/images/profile.jpg',
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: StyleText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.005,
              ),
              if (postState.isLoading) ...{
                const Center(child: CircularProgressIndicator()),
              } else if (postState.error != null) ...{
                Text(postState.error.toString()),
              } else if (postState.posts.isEmpty) ...{
                const Center(child: Text('No Post Found')),
              } else ...{
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      PostEntity post = postList[index];
                      return Card(
                        elevation: 4.0,
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                              ),
                              // User information section
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/profile.jpg"),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        AuthState.userEntity?.fullName ??
                                            "User",
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Description and image section
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Adding spacing above the description text
                                    const SizedBox(height: 60),
                                    Text(
                                      post.description,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                        height:
                                            10), // Adding spacing below the description text
                                    AspectRatio(
                                      aspectRatio: 3 /
                                          2, // Adjust the aspect ratio for a shorter image
                                      child: Image.network(
                                        'http://10.0.2.2:4000/uploads/${post.image}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // IconButtons added here
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.favorite),
                                          color: Colors.blue,
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.share),
                                          color: Colors.blue,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Action buttons section below the image
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
