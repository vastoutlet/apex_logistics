import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/auth/verify_otp.dart';
import 'package:apex_logistics/views/home/users/chooseRider.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:apex_logistics/views/home/users/decide_route.dart';
import 'package:apex_logistics/views/home/users/package_content.dart';
import 'package:apex_logistics/views/home/users/rider_arriving.dart';
import 'package:apex_logistics/views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  // Intro Screen
  static String splash = "/";
  static String onboarding = "/onboarding";
  static String signIn = "/signIn";
  static String verifyOTP = "/verifyOTP";

  //  User Screen
  static String decideRoute = "/decideRoute";
  static String confirmAddress = "/confirmAddress";
  static String packageContent = "/packageContent";
  static String chooseRider = "/chooseRider";
  static String riderArriving = "/riderArriving";
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
  GetPage(
    name: Routes.decideRoute,
    page: () => const DecideRoute(),
  ),
  GetPage(
    name: Routes.confirmAddress,
    page: () => ConfirmAddress(),
  ),
  GetPage(
    name: Routes.packageContent,
    page: () => PackageContent(),
  ),
  GetPage(
    name: Routes.chooseRider,
    page: () => ChooseRider(),
  ),
  GetPage(
    name: Routes.riderArriving,
    page: () => RiderArriving(),
  ),
];
