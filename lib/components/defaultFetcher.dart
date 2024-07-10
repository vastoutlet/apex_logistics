import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultFetcher extends StatelessWidget {
  const DefaultFetcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                    color: Constants.primaryNormal,
                  ),
                  const SizedBox(height: 10),
                  const CircularProgressIndicator(
                    color: Constants.primaryNormal,
                  ),
                ],
              ),
            );
  }
}
