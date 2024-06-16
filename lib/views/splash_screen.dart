import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apex_logistics/main.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool onboarding = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onboarding.value = sharedPreferences.getBool("onboard") ?? false;
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Constants.primarydark,
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 400),
          ],
        ),
      ),
      // backgroundColor: Constants.backgroundColor,
      splashIconSize: 300.0,
      nextScreen: controller.onboarding.value ? const SignIn() : Onboarding(),
    );
  }
}
