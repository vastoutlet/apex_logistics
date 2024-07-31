import 'package:apex_logistics/views/auth/profile.dart';
import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/auth/link_authentication.dart';
import 'package:apex_logistics/views/auth/verify_otp.dart';
import 'package:apex_logistics/views/home/users/add_card.dart';
import 'package:apex_logistics/views/home/users/chooseRider.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:apex_logistics/views/home/users/decide_route.dart';
import 'package:apex_logistics/views/home/users/my_ride.dart';
import 'package:apex_logistics/views/home/users/my_ride_details.dart';
import 'package:apex_logistics/views/home/users/package_content.dart';
import 'package:apex_logistics/views/home/users/payment.dart';
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
  static String myRide = "/myRide";
  static String myRideDetail = "/myRideDetail";
  static String payment = "/payment";
  static String addNewCard = "/addNewCard";
  static String profile = "/profile";
  static String linkAuthentication = "/linkAuthentication";
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
    name: Routes.linkAuthentication,
    page: () => LinkAuthentication(
      imagePath: Get.arguments['imagePath'],
      heading: Get.arguments['heading'],
      subtitle: Get.arguments['subtitle'],
      method: Get.arguments['method'],
    ),
  ),
  GetPage(
    name: Routes.verifyOTP,
    page: () => const VerifyOTP(),
  ),
  GetPage(
    name: Routes.decideRoute,
    page: () => DecideRoute(),
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
  GetPage(
    name: Routes.myRide,
    page: () => MyRide(),
  ),
  GetPage(
    name: Routes.myRideDetail,
    page: () => MyRideDetail(),
  ),
  GetPage(
    name: Routes.payment,
    page: () => PaymentMethod(),
  ),
  GetPage(
    name: Routes.addNewCard,
    page: () => AddCard(),
  ),
  GetPage(
    name: Routes.profile,
    page: () => Profile(),
  ),
];
