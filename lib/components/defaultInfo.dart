import 'package:apex_logistics/components/defaultText.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DefaultInfo extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String? subtitle;
  const DefaultInfo({
    this.imagePath = "assets/images/empty.json",
    required this.title,
    this.subtitle = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            imagePath!,
            width: 400,
            height: 300,
          ),
          DefaultText(
            text: title,
            weight: FontWeight.bold,
            size: 20,
          ),
          const SizedBox(height: 10),
          DefaultText(
            text:
                subtitle,
            size: 15,
          ),
        ],
      ),
    );
  }
}
