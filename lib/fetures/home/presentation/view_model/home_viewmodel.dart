import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/snackbar.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>(
  (ref) => HomeViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

class HomeViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  HomeViewModel(this._userSharedPrefs) : super(false);

  void logout(BuildContext context) async {
    state = true;
    showSnackBar(context: context, message: "Loggin out...");

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.signInRoute,
        (route) => false,
      );
    });
  }
}
