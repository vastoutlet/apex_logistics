import 'dart:async';
import 'dart:ffi';
import 'package:apex_logistics/components/defaultAppBar2.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultOtpForm.dart';
import 'package:apex_logistics/components/defaultSnackBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/sign_in_controller.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  SignInController signInController = Get.put(SignInController());
  var arguments;

  final _formKey = GlobalKey<FormState>();

  Color uiColor = Constants.primaryNormal;
  Color disabledColor = Constants.whiteDark;
  bool isValid = true;

  Duration _duration = const Duration(minutes: 2); // Duration of the timer
  Timer? _timer; // Timer object
  int _countdown = 0; // count down value
  final int _otpBoxes = 6;

  // Method for requesting new OTP
  void resendOTP() {
    if (_countdown != 0) {
      defaultSnackBar(context, false, "Resend after ${_countdown}s");
    } else {
      defaultSnackBar(context, true, "new OTP requested");

      signInController.signInWithPhone(
          resendOTPToken: signInController.resendToken.value);
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

    startTimer(); // Start countdown
    arguments = Get.arguments;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Constants.blackNormal,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Constants.primaryNormal),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Constants.errorDark),
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      backgroundColor: Constants.whiteLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppBar2(
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
                    Text.rich(
                      TextSpan(
                          text: "we have sent a code to ",
                          style: const TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(
                                text: "${arguments['phoneNumber']}",
                                style: const TextStyle(
                                    fontFamily: "RobotoRegular",
                                    color: Constants.primarydark,
                                    fontSize: 16.0))
                          ]),
                    ),
                    // DefaultText(
                    //     text:
                    //         "we have sent a code to ${arguments['phoneNumber']}",
                    //     size: 18,
                    //     weight: FontWeight.normal,
                    //     fontColor: Constants.primaryNormal),

                    // TextField
                    const SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      child: SizedBox(
                        child: Pinput(
                          length: 6,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme,
                          errorPinTheme: errorPinTheme,
                          controller: signInController.otpController,
                          onChanged: (pin) {
                            signInController.otpControllerText.value = pin;
                          },
                          onCompleted: (pin) {
                            signInController.customError.value = "";
                          },
                          validator: (pin) {
                            if (signInController.customError.value != "") {
                              return signInController.customError.value;
                            }
                            return null;
                          },
                        ),
                      ),
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
                      ],
                    ),

                    // confirm button
                    const SizedBox(height: 10),
                    Obx(
                      () => DefaultButton(
                        onPressed: () async {
                          if (signInController.otpControllerText.value.length ==
                              _otpBoxes) {
                            await signInController.verifyOTP();
                            _formKey.currentState!.validate();
                          } else {
                            null;
                          }
                        },
                        buttonColor:
                            signInController.otpControllerText.value.length ==
                                    _otpBoxes
                                ? uiColor
                                : disabledColor,
                        child: signInController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Constants.whiteNormal,
                              )
                            : DefaultText(
                                text: "Confirm",
                                fontColor: signInController
                                            .otpControllerText.value.length ==
                                        _otpBoxes
                                    ? Constants.whiteNormal
                                    : Constants.blackNormal,
                                size: 16,
                              ),
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
