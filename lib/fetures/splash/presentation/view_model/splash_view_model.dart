import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:room_finder_app/config/router/app_route.dart';
import 'package:room_finder_app/fetures/auth/domain/entity/user_entity.dart';

import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../auth/presentation/state/auth_state.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  UserEntity? userEntity;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) async {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          Navigator.popAndPushNamed(context, AppRoute.signInRoute);
        } else {
          UserEntity? user;

          var data = await _userSharedPrefs.getUserEntity();

          data.fold((fail) => user = null, (success) => user = success!);

          if (user != null) {
            AuthState.userEntity = user;
            // UserEntity.userId = ;
          }
          Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.signInRoute);
      }
    });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    int expirationTimestamp = decodedToken['exp'];

    final currentDate = DateTime.now().millisecondsSinceEpoch;
    // If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }
}
