import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/fetures/auth/domain/entity/user_entity.dart';
import 'package:room_finder_app/fetures/auth/presentation/state/auth_state.dart';
import 'package:room_finder_app/fetures/home/presentation/view/bottom_view/account_view.dart';
import 'package:room_finder_app/fetures/home/presentation/view/bottom_view/home_view.dart';
import 'package:room_finder_app/fetures/room/presentation/view/add_room_view.dart';
import 'package:room_finder_app/fetures/room/presentation/view/update_rooms.dart';

class DashBoard extends ConsumerStatefulWidget {
  final int? index;
  const DashBoard({super.key, this.index});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  int _selectedIndex = 0;
  List<Widget> lstButtonScreen = [
    const HomeView(),
    const AddRooms(),
    const AccountView(),
    
  ];

  UserEntity? userEntity = AuthState.userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstButtonScreen[widget.index ?? _selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
         
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
