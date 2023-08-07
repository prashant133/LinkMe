

import '../../fetures/auth/presentation/view/login.dart';
import '../../fetures/auth/presentation/view/register.dart';
import '../../fetures/home/presentation/view/dashboard.dart';
import '../../fetures/post/presentation/view/upload_image_view.dart';

import '../../fetures/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String dashboardRoute = '/home';
  static const String signInRoute = '/signIn';
  static const String singUpRoute = '/signUp';
  static const String uploadViews = '/upload';
  static const String updatePost = '/update';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      signInRoute: (context) => const LogIn(),
      singUpRoute: (context) => const Register(),
      dashboardRoute: (context) => const DashBoard(),
      uploadViews: (context) => const UploadView(),
      
    };
  }
}
