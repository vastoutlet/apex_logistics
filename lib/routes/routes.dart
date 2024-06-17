import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/auth/verify_otp.dart';
import 'package:apex_logistics/views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String splash = "/";
  static String onboarding = "/onboarding";
  static String signIn = "/signIn";
  static String verifyOTP = "/verifyOTP";
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: Routes.signIn,
    page: () => SignIn(),
  ),
  GetPage(
    name: Routes.verifyOTP,
    page: () => const VerifyOTP(),
  ),
];
