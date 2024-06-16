import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/defaultOtpForm.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppBar(
                backgroundColor: Constants.whiteLight,
                iconColor: Constants.blackNormal,
                icon: Icons.arrow_back,
                onPressed: () => Get.back(),
              ),
              // Heading
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    const DefaultText(
                      text: "Enter the code",
                      size: 20,
                      weight: FontWeight.bold,
                    ),

                    // Heading
                    const SizedBox(height: 10),
                    const DefaultText(
                      text: "we have sent a code to +2347063179312",
                      size: 18,
                      weight: FontWeight.normal,
                    ),

                    // TextField
                    const SizedBox(height: 20),
                    const DefaultOtpForm(),

                    // resend code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const DefaultText(
                            text: "Resend Code after 1:30s",
                          ),
                        ),
                      ],
                    ),

                    // didn't receive
                    TextButton(
                      onPressed: () {},
                      child: const DefaultText(
                        text: "Didn't receive the Code",
                        decoration: TextDecoration.underline,
                      ),
                    ),

                    // confirm button
                    const SizedBox(height: 10),
                    DefaultButton(
                      onPressed: () {},
                      child: const DefaultText(
                        text: "Confirm",
                        fontColor: Constants.whiteNormal,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
