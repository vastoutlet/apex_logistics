import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultSnackBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/sign_in_controller.dart';
import 'package:apex_logistics/main.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:apex_logistics/utils/form_validator.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  DateTime timeBackPressed = DateTime.now();

  SignInController signInController = Get.put(SignInController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            final difference = DateTime.now().difference(timeBackPressed);
            final isExitWarning = difference >= const Duration(seconds: 2);
            timeBackPressed = DateTime.now();

            if (didPop) {
              return;
            }

            if (isExitWarning) {
              showToast(
                'Press back again to exit',
                context: context,
                animation: StyledToastAnimation.slideFromTopFade,
                position: StyledToastPosition.top,
              );
            } else {
              SystemNavigator.pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                // Heading
                const AutoSizeText(
                  maxLines: 1,
                  "Sign in with your phone number",
                  style: TextStyle(
                    fontFamily: "RobotoRegular",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                // Subtitle
                const AutoSizeText(
                  maxLines: 1,
                  "we'll text a code to verify your number",
                  style: TextStyle(
                    fontFamily: "RobotoRegular",
                    fontSize: 18,
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Phone number text field
                      const SizedBox(height: 40),
                      DefaultForm(
                        icon: Image.asset("assets/images/flag.png"),
                        hintText: "phone number",
                        controller: signInController.phoneNumberController,
                        validator: FormValidator.phoneValidator,
                        keyboardType: TextInputType.phone,
                      ),

                      // Sign in button
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: DefaultButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sharedPreferences.setBool("driver", false);
                              Get.toNamed(Routes.decideRoute);
                              // signInController.signInWithPhone();
                            }
                          },
                          child: const DefaultText(
                            text: "Sign in",
                            fontColor: Constants.whiteNormal,
                            size: 18,
                          ),
                        ),
                      ),

                      // text
                      const SizedBox(height: 20),
                      const DefaultText(
                        text: "Or login with",
                        size: 18,
                        weight: FontWeight.normal,
                      ),

                      // Sign in with google
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: DefaultButton(
                          borderColor: Constants.primaryNormal,
                          buttonColor: Constants.whiteNormal,
                          onPressed: () {
                            sharedPreferences.setBool("driver", false);
                            signInController.signInWithGoogle(false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/google.png",
                                width: 30,
                              ),
                              const SizedBox(width: 25),
                              const DefaultText(
                                text: "Sign in with Google",
                                size: 18,
                                weight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // terms
                const Spacer(),
                const DefaultText(
                  text:
                      "By signing up, you agree to our Terms & Conditions, acknowledge our Privacy Policy, and confirm that you're over 18. we may send promotions related to our services-you can unsubscribe anytime in Communication settings under your Profile.",
                  size: 13,
                  align: TextAlign.center,
                  weight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
