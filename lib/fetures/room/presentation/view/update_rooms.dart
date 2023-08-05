import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/common/snackbar/snackbar.dart';
import 'package:room_finder_app/fetures/room/domain/entity/room_entity.dart';
import 'package:room_finder_app/fetures/room/presentation/view_model/room_get_my_room_view_model.dart';

class UpdateView extends ConsumerStatefulWidget {
  const UpdateView({super.key, required this.room});
  final RoomEntity room;

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
    _titleController = TextEditingController(text: widget.room.title);
    _descriptionController =
        TextEditingController(text: widget.room.description);
    _locationController = TextEditingController(text: widget.room.location);
    _phoneNumberController =
        TextEditingController(text: widget.room.phoneNumber.toString());
    _priceController =
        TextEditingController(text: widget.room.price.toString());
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
        title: const Text("Update rooms"),
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
                      hintText: "Write the title of the room",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please insert the title of the room";
                      }
                      return null;
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: "Location",
                      hintText: "Enter the location of the room",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the location of a Room";
                      }
                      return null;
                    },
                  ),
                  gap,
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      hintText: "Enter the Price of the rooms",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please give the price of the room";
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
                      hintText: "Write description of the Room",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please write the description of the room";
                      }
                      return null;
                    },
                  ),
                  gap,
                  ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          RoomEntity room = RoomEntity(
                            title: _titleController.text,
                            location: _locationController.text,
                            description: _descriptionController.text,
                            price: int.parse(_priceController.text),
                            phoneNumber: int.parse(_phoneNumberController.text),
                            user: '',
                          );
                          ref
                              .watch(roomGetMyRoomViewModelProvider.notifier)
                              .updateRoom(room, widget.room.roomId!);
                          ref
                              .watch(roomGetMyRoomViewModelProvider.notifier)
                              .getMyRooms()
                              .then((value) {
                            Navigator.pop(context);
                            showSnackBar(
                              context: context,
                              message: "Room updated successfully",
                              color: Colors.green,
                            );
                          });
                        }
                      },
                      child: const Text('Update rooms'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
