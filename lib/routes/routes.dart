import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String splash = "/";
  static String onboarding = "/onboarding";
  static String signin = "/signin";
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: Routes.signin,
    page: () => const SignIn(),
  ),
];
