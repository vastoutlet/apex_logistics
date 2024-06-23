import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.primaryNormal,
      appBar: DefaultAppBar(title: "Payment"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                const DefaultText(
                  text: "Payment Method",
                  size: 18.0,
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.addNewCard);
                    },
                    child: const DefaultText(
                      text: "Add New Card",
                      fontColor: Constants.primaryNormal,
                      size: 18.0,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
