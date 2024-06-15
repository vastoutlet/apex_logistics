import 'package:apex_logistics/views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String splash = "/";
  static String onboarding = "/onboarding";
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const SplashScreen(),
  ),
];
