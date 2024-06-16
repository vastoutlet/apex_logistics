import 'package:apex_logistics/components/defaultText.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: DefaultText(text: "Sign In/Sign Up")));
  }
}
