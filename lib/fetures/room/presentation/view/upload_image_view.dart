import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_finder_app/config/router/app_route.dart';
import 'package:room_finder_app/core/common/snackbar/snackbar.dart';

import '../../domain/entity/room_entity.dart';
import '../view_model/room_viewmodel.dart';

class UploadView extends ConsumerStatefulWidget {
  const UploadView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadViewState();
}

class _UploadViewState extends ConsumerState<UploadView> {
  // checkCameraPermission() async {
  //   if (await Permission.camera.request().isRestricted ||
  //       await Permission.camera.request().isDenied) {
  //     await Permission.camera.request();
  //   }
  // }

  File? _img;
  // after add post
  String actualPostId = RoomEntity.postId;

  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 4096,
        maxHeight: 4095,
        imageQuality: 85,
      );
      if (image != null) {
        final file = File(image.path);
        if (await file.length() <= 1024 * 1024) {
          setState(() {
            _img = File(image.path);
            ref
                .read(roomViewModelProvider.notifier)
                .uploadImage(_img!, actualPostId);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 2000), () {
            showSnackBar(
                context: context, message: 'Image must be less than 4MB');
          });
        }
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(
      height: 50,
    );
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              "Select Image which  is less than 4MB ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            gap,
            InkWell(
              onTap: () {
                _browseImage(ref, ImageSource.gallery);
              },
              child: SizedBox(
                width: double.infinity,
                height: height * 0.5,
                child: _img != null
                    ? Image.file(
                        _img!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/2.png',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            gap,
            ElevatedButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
                ref.watch(roomViewModelProvider.notifier).getAllRooms();
              },
              child: const Text('Add Image'),
            ),
          ],
        ),
      ),
    );
  }
}
