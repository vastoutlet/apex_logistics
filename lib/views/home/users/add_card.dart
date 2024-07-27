import 'package:apex_logistics/components/card_input_formatters.dart';
import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/add_card_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final controller = Get.put(AddNewCardController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const DefaultAppBar(title: "Add New Card"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          children: [
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Obx(() => DefaultForm(
                        controller: controller.cardNumberController,
                        borderWidth: 5,
                        focusedBorderColor: Constants.primaryNormal,
                        icon: controller.cardTypeIcon.value,
                        hintText: "Card Number",
                        keyboardType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter()
                        ],
                        validator: CardUtils.validateCardNum,
                        onSaved: (value) {
                          print("value is $value");
                          controller.paymentCard.value.number =
                              CardUtils.getCleanedNumber(value!);
                        })),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DefaultForm(
                            borderWidth: 5,
                            focusedBorderColor: Constants.primaryNormal,
                            hintText: "Secure Code",
                            keyboardType: TextInputType.phone,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            validator: CardUtils.validateCVV,
                            onSaved: (value) => controller
                                .paymentCard.value.cvv = int.parse(value!),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: DefaultForm(
                            borderWidth: 5,
                            focusedBorderColor: Constants.primaryNormal,
                            // icon: Icons.add_card,
                            hintText: "Expiry Date",
                            keyboardType: TextInputType.number,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMonthInputFormatter()
                            ],
                            validator: CardUtils.validateExpiryDate,
                            onSaved: (value) {
                              List<int> expiryDate =
                                  CardUtils.getExpiryDate(value!);
                              controller.paymentCard.value.month =
                                  expiryDate[0];
                              controller.paymentCard.value.year = expiryDate[1];
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Obx(() => DefaultButton(
                          buttonColor: controller.isCardNumberNotEmpty.value
                              ? Constants.primaryNormal
                              : Constants.whiteDark,
                          onPressed: controller.isCardNumberNotEmpty.value
                              ? () {
                                  controller.saveCardDetails(context);
                                }
                              : null,
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
