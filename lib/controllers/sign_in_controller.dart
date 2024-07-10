import 'package:apex_logistics/components/defaultLoader.dart';
import 'package:apex_logistics/components/defaultSnackBar.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxBool isButtonEnabled = false.obs;
  var verificationID = "".obs;
  RxInt resendToken = 0.obs;
  var customError = "".obs;

  // signInMethod: Phone
  Future signInWithPhone({int? resendOTPToken}) async {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => const DefaultLoader(),
    );

    await auth.verifyPhoneNumber(
      phoneNumber: '+234${phoneNumberController.text.substring(1)}',
      forceResendingToken: resendOTPToken,
      timeout: const Duration(seconds: 60),
      // Only gets called on a device that support automatic code resolution
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        otpController.text = credential.smsCode!;
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        navigator!.pop(Get.context!);
        if (e.code == 'invalid-phone-number') {
          defaultSnackBar(Get.overlayContext!, false, Strings.phoneIsInvalid);
        } else {
          defaultSnackBar(
            Get.overlayContext!,
            false,
            "something went wrong, try again later!",
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID.value = verificationId;
        this.resendToken.value = resendToken!;
        navigator!.pop(Get.context!);

        if (resendOTPToken == null) {
          Get.toNamed(Routes.verifyOTP, arguments: {
            'phoneNumber': phoneNumberController.text,
          });
        }
        otpController.clear();
        isButtonEnabled.value = false;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID.value = verificationId;
      },
    );
  }

  // Verify OTP
  Future<void> verifyOTP() async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value,
        smsCode: otpController.text,
      );

      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // Sign in with the credential if no user is currently signed in
        var credentials = await auth.signInWithCredential(credential);
        if (credentials.user != null) {
          otpController.clear();

          List<UserInfo> providers = auth.currentUser!.providerData;
          if (providers.length > 1) {
            Get.toNamed(Routes.decideRoute);
            defaultSnackBar(Get.overlayContext!, true, "Sign in successful!");
          } else {
            Get.toNamed(Routes.linkAuthentication, arguments: {
              "imagePath": "assets/images/link1.json",
              "heading": "Link Account with Google",
              "subtitle":
                  "Complete linking your account to enable seamless access",
              "method": "google",
            });
          }
        }
      } else {
        // Perform linking with current user
        await linkCredentials(credential);
      }
    } catch (e) {
      String errorMessage = "An unknown error occurred. Please try again.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case "invalid-verification-code":
            customError.value = "Invalid Code";
            break;
          default:
            defaultSnackBar(Get.overlayContext!, false, errorMessage);
        }
      } else {
        defaultSnackBar(Get.overlayContext!, false, errorMessage);
      }
    }
  }

  // signInMethod: Google
  Future<void> signInWithGoogle(bool shouldLink) async {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => const DefaultLoader(),
    );

    try {
      // Begin interactive signing process
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        navigator!.pop(Get.context!);
        defaultSnackBar(
            Get.overlayContext!, false, "Sign-in cancelled by user.");
        return;
      }

      // Obtain auth details from request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a credential
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      if (!shouldLink) {
        // Sign-in using firebase
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        navigator!.pop(Get.context!);

        if (userCredential.user != null) {
          List<UserInfo> providers = auth.currentUser!.providerData;
          if (providers.length > 1) {
            Get.toNamed(Routes.decideRoute);
            defaultSnackBar(Get.overlayContext!, true, "Sign in successful!");
            return;
          } else {
            Get.toNamed(Routes.linkAuthentication, arguments: {
              "imagePath": "assets/images/link1.json",
              "heading": "Link Account with Phone Number",
              "subtitle": "we'll text a code to verify your number",
              "method": "phone",
            });
            defaultSnackBar(Get.overlayContext!, true,
                "Proceed with linking phone number!");
          }
        }
      } else {
        // Perform linking with current user
        linkCredentials(credential);
      }
    } catch (e) {
      print("ERROR-SIGN IN WITH GOOGLE: ${e.toString()}");
      defaultSnackBar(Get.overlayContext!, false,
          "Something went wrong, please try again!");
    }
  }

  // link two authentication method
  Future<void> linkCredentials(AuthCredential credential) async {
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);

      // navigator!.pop(Get.context!);

      Get.offAll(Routes.decideRoute);
      defaultSnackBar(Get.overlayContext!, true, "Sign in successful!");
    } on FirebaseAuthException catch (e) {
      navigator!.pop(Get.context!);

      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          Get.toNamed(Routes.decideRoute);
          break;
        case "invalid-credential":
          defaultSnackBar(Get.overlayContext!, false,
              "The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          defaultSnackBar(Get.overlayContext!, false,
              "The account corresponding to the credential already exists!");
          break;
        // See the API reference for the full list of error codes.
        default:
          defaultSnackBar(
              Get.overlayContext!, false, "something went wrong, try again!");
          print("linkCredentials: Unknown error.");
      }
    }
  }
}
