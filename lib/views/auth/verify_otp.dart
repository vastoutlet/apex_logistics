import 'dart:async';

import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultOtpForm.dart';
import 'package:apex_logistics/components/defaultSnackBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  Color uiColor = Constants.primaryNormal;
  bool isValid = true;
  bool isVisible = false;

  Duration _duration = const Duration(minutes: 2); // Duration of the timer
  Timer? _timer; // Timer object
  int _countdown = 0; // count down value

  // Method to change UI color
  void toggleColor(bool value) {
    const Color errorColor = Constants.errorDark;
    const Color successColor = Constants.primaryNormal;

    setState(() {
      if (value) {
        uiColor = successColor;
        isVisible = !value;
      } else {
        uiColor = errorColor;
        isVisible = !value;
      }
      isValid = !!value;
    });
  }

  // Method for requesting new OTP
  void resendOTP() {
    if (_countdown != 0) {
      defaultSnackBar(context, false, "Resend after ${_countdown}s");
    } else {
      defaultSnackBar(context, true, "new OTP requested");
      setState(() {
        _duration = const Duration(minutes: 2);
        startTimer();
      });
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds < 0) {
        // countdown finished
        _timer?.cancel();
      } else {
        setState(() {
          _countdown = _duration.inSeconds;
          _duration = _duration - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Start countdown
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                    DefaultOtpForm(
                      borderColor: uiColor,
                    ),

                    // resend code & invalid code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Resend code
                        TextButton(
                          onPressed: () => resendOTP(),
                          child: DefaultText(
                            text:
                                "Click here to resend Code after ${_countdown}s",
                          ),
                        ),
                        // Invalid code
                        Visibility(
                          visible: isVisible,
                          child: TextButton(
                            onPressed: () {},
                            child: DefaultText(
                              text: "Invalid Code",
                              fontColor: uiColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // confirm button
                    const SizedBox(height: 10),
                    DefaultButton(
                      onPressed: () => toggleColor(!isValid),
                      buttonColor: uiColor,
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
