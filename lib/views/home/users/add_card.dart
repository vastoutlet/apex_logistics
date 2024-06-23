import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/add_card_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final controller = Get.put(AddNewCardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: DefaultAppBar(title: "Add New Card"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                DefaultForm(
                  controller: controller.cardNumberController,
                  borderWidth: 5,
                  focusedBorderColor: Constants.primaryNormal,
                  icon: Icons.add_card,
                  hintText: "Card Number",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DefaultForm(
                        borderWidth: 5,
                        focusedBorderColor: Constants.primaryNormal,
                        hintText: "Secure Code",
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: DefaultForm(
                        borderWidth: 5,
                        focusedBorderColor: Constants.primaryNormal,
                        // icon: Icons.add_card,
                        hintText: "Expiry Date",
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40.0),
                Obx(() => DefaultButton(
                      buttonColor: controller.isCardNumberNotEmpty.value
                          ? Constants.primaryNormal
                          : Constants.whiteDark,
                      onPressed: () {},
                      child: const DefaultText(
                        text: "Add Card",
                        fontColor: Constants.whiteNormal,
                        size: 18,
                      ),
                    ))
              ],
            )),
            const SizedBox(height: 70.0),
            const Center(
              child: DefaultText(
                text:
                    "Apex Logistics may charge a small amount to confirm your card details. This is immediately refunded.",
                fontColor: Colors.grey,
                align: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
