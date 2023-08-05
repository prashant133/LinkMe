import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/fetures/auth/presentation/state/auth_state.dart';

import '../../../../../core/common/Provider/is_dark_theme.dart';
import '../../../../room/domain/entity/room_entity.dart';
import '../../../../room/presentation/view_model/room_get_my_room_view_model.dart';
import '../../../data/model/shake_sensor.dart';
import '../../view_model/home_viewmodel.dart';

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  ConsumerState<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends ConsumerState<AccountView> {
  late bool isDark = false;
  late ShakeSensor shakeSensor;

  // List<RoomEntity> _filteredRooms = [];

  // void _getMyRooms(List<RoomEntity> roomList) {
  //   _filteredRooms = roomList
  //       .where((room) => room.user == AuthState.userEntity!.id)
  //       .toList();
  // }

  @override
  void initState() {
    super.initState();
    isDark = ref.read(isDarkThemeProvider);
    shakeSensor = ShakeSensor(onShake: _onShake);
  }

  void _onShake() {
    setState(() {
      isDark = !isDark;
    });
    ref.read(isDarkThemeProvider.notifier).updateTheme(isDark);
  }

  void _handleLogout(BuildContext context) {
    ref.read(homeViewModelProvider.notifier).logout(context);
  }

  @override
  Widget build(BuildContext context) {
    // all rooms
    final roomState = ref.watch(roomGetMyRoomViewModelProvider);

    final List<RoomEntity> roomList = roomState.rooms;

    final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Hi, ${AuthState.userEntity?.fullName ?? "User"}'),
          actions: [
            IconButton(
              onPressed: () {
                _handleLogout(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
                ref.read(isDarkThemeProvider.notifier).updateTheme(value);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Background image
                    Image.asset(
                      "assets/images/background.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    // CircleAvatar and Text positioned
                    Positioned(
                      bottom: -30,
                      left: 0, // Adjust the left value according to your needs
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                          ),
                          const SizedBox(height: 10), // Add some spacing
                          // Text positioned at the bottom-right corner of the CircleAvatar
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child:
                                Text(AuthState.userEntity?.fullName ?? "User"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: roomList.length,
                  itemBuilder: (context, index) {
                    RoomEntity room = roomList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      shadowColor: const Color.fromARGB(255, 211, 199, 199),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.02 * width,
                          ),
                          Text(
                            room.description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(3)),
                          SizedBox(
                            width: width * 0.4,
                            height: width * 0.22,
                            child: Image.network(
                              'http://10.0.2.2:4000/uploads/${room.image}',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: width * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete post'),
                                        content: const Text(
                                          'Are you sure you want to delete this Room?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(
                                                      roomGetMyRoomViewModelProvider
                                                          .notifier)
                                                  .deleteRoom(
                                                      context, room.roomId!);

                                              ref
                                                  .read(
                                                      roomGetMyRoomViewModelProvider
                                                          .notifier)
                                                  .getMyRooms();
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Room deleted successfully'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
