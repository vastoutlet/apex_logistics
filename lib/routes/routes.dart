import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String splash = "/";
  static String onboarding = "/onboarding";
  static String signIn = "/signIn";
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: Routes.signIn,
    page: () => const SignIn(),
  ),
];
