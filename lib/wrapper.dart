import 'package:apex_logistics/components/defaultFetcher.dart';
import 'package:apex_logistics/components/defaultInfo.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/auth/link_authentication.dart';
import 'package:apex_logistics/views/auth/signin.dart';
import 'package:apex_logistics/views/home/users/decide_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();

    return Scaffold(
      backgroundColor: Constants.whiteNormal,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DefaultFetcher();
          } else if (snapshot.hasError) {
            return const DefaultInfo(
              title: "Something Went Wrong!",
              subtitle: "kindly try again",
            );
          } else if (snapshot.hasData) {
            // check for the userType (userType == driver)? driverHomepage : userHomepage

            final user = FirebaseAuth.instance.currentUser;
            List<UserInfo> providers = user!.providerData;

            if (providers.length > 1) {
              return const DecideRoute();
            } else {
              final firstProviderId = providers.first.providerId;
              return LinkAuthentication(
                imagePath: "assets/images/link1.json",
                heading: firstProviderId == "google.com"
                    ? "Link Account with Phone Number"
                    : "Link Account with Google",
                subtitle: firstProviderId == "google.com"
                    ? "we'll text a code to verify your number"
                    : "Complete linking your account to enable seamless access",
                method: firstProviderId == "google.com" ? "phone" : "google",
              );
            }
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}
