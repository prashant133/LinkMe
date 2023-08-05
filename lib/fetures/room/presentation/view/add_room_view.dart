import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/common/snackbar/snackbar.dart';

import '../../domain/entity/room_entity.dart';
import '../view_model/room_viewmodel.dart';

class AddRooms extends ConsumerStatefulWidget {
  const AddRooms({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddRoomsState();
}

class _AddRoomsState extends ConsumerState<AddRooms> {
  final _titleController = TextEditingController();
  final _descrpitionController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descrpitionController.dispose();
    _priceController.dispose();
    _phoneNumberController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final roomState = ref.watch(roomViewModelProvider);
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
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: "Title ",
                          hintText: "Enter the Title or the Room ",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please wirte the title of the room ';
                          }
                          return null;
                        },
                      ),
                      gap,
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Enter your Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please wirte  your contact number ';
                          }
                          return null;
                        },
                      ),
                      gap,
                      TextFormField(
                        controller: _descrpitionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write the descrpition of the room';
                          }
                          return null;
                        },
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Descrpition",
                          hintText: "Write descrptions about the room",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      gap,
                      TextFormField(
                        controller: _locationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please insert the location of the room';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Location",
                          hintText: "Enter the location ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      gap,
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write the price of the room';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Price",
                          hintText: "Put the price of your rooms",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(
                        width: width * 0.55,
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              RoomEntity room = RoomEntity(
                                title: _titleController.text,
                                location: _locationController.text,
                                description: _descrpitionController.text,
                                phoneNumber: int.parse(_phoneNumberController.text),
                                price: int.parse(_priceController.text),
                                user: '',
                              );
                              ref
                                  .read(roomViewModelProvider.notifier)
                                  .addRooms(room, context);
                            }
                            if (roomState.error != null) {
                              showSnackBar(
                                context: context,
                                message: roomState.error.toString(),
                              );
                            } else {
                              showSnackBar(
                                context: context,
                                message: 'Added Room Descpriotions',
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
