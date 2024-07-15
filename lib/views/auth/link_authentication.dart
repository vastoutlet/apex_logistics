import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/sign_in_controller.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:apex_logistics/utils/form_validator.dart';
import 'package:lottie/lottie.dart';

class LinkAuthentication extends StatefulWidget {
  final String imagePath;
  final String heading;
  final String subtitle;
  final String method;

  const LinkAuthentication({
    required this.imagePath,
    required this.heading,
    required this.subtitle,
    required this.method,
    super.key,
  });

  @override
  State<LinkAuthentication> createState() => _LinkAuthenticationState();
}

class _LinkAuthenticationState extends State<LinkAuthentication> {

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
            if (didPop) {
              return;
            }
            Get.toNamed(Routes.signIn);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // SVG
                  Lottie.asset(
                    widget.imagePath,
                    width: 400,
                    height: 300,
                  ),
                  // Heading
                  DefaultText(
                    text: widget.heading,
                    size: 25,
                    weight: FontWeight.bold,
                  ),

                  // Subtitle
                  const SizedBox(height: 10),
                  DefaultText(
                    text: widget.subtitle,
                    size: 18,
                    weight: FontWeight.normal,
                  ),

                  // Phone number text field
                  if (widget.method == 'phone') ...[
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
                            signInController.signInWithPhone();
                          }
                        },
                        child: const DefaultText(
                          text: "Link Phone Number",
                          fontColor: Constants.whiteNormal,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                  // Sign in with google
                  if (widget.method == 'google') ...[
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: DefaultButton(
                        borderColor: Constants.primaryNormal,
                        buttonColor: Constants.whiteNormal,
                        onPressed: () =>
                            signInController.signInWithGoogle(true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              width: 20,
                            ),
                            const SizedBox(width: 25),
                            const DefaultText(
                              text: "Link with Google",
                              size: 18,
                              weight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
