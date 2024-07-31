import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultLoader.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/payment_controller.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({super.key});

  final controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Payment"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                const DefaultText(
                  text: "Payment Methods",
                  size: 18.0,
                  weight: FontWeight.bold,
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
            ),
            Container(
              decoration: BoxDecoration(
                  color: Constants.whiteNormal,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1.0,
                    color: Constants.whiteDark,
                  )),
              child: Obx(() => ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.paymentMethod.length,
                  itemBuilder: (context, index) {
                    bool isLastItem =
                        index == controller.paymentMethod.length - 1;
                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Constants.whiteDark))),
                      child: ListTile(
                        leading: controller.paymentIcon[index],
                        title: controller.paymentMethod[index],
                        trailing: !isLastItem
                            ? Obx(
                                () => Radio(
                                  value: "method$index",
                                  groupValue:
                                      controller.met.value, //selected value
                                  onChanged: null,
                                ),
                              )
                            : null,
                        onTap: !isLastItem
                            ? () => showDialog(
                                barrierDismissible: false,
                                builder: (context) => DefaultLoader(
                                      widthSize: 0.8,
                                      content: Column(
                                        children: [
                                          const Expanded(
                                            child: DefaultText(
                                              text:
                                                  "What do you want to do with this card?",
                                              size: 18.0,
                                              weight: FontWeight.bold,
                                              align: TextAlign.center,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    // run remote link
                                                    controller
                                                        .setDefaultPayment(
                                                            index);
                                                    Get.close(1);
                                                  },
                                                  child: const DefaultText(
                                                    text: "Set as Default",
                                                    size: 18.0,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.close(1);
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: Get.context!,
                                                      builder: (context) {
                                                        return DefaultLoader(
                                                          height: 150,
                                                          content: Column(
                                                            children: [
                                                              const DefaultText(
                                                                text:
                                                                    "Delete Card?",
                                                                weight:
                                                                    FontWeight
                                                                        .bold,
                                                                size: 20.0,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10.0),
                                                              Expanded(
                                                                child:
                                                                    DefaultText(
                                                                  text:
                                                                      "This will remove the payment method from your account",
                                                                  size: 16.0,
                                                                  fontColor:
                                                                      Colors.grey[
                                                                          600],
                                                                  align: TextAlign
                                                                      .center,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: DefaultButton(
                                                                          buttonColor: Colors.red,
                                                                          onPressed: () {},
                                                                          child: const DefaultText(
                                                                            text:
                                                                                "Delete",
                                                                            fontColor:
                                                                                Constants.whiteLight,
                                                                            size:
                                                                                16.0,
                                                                          ))),
                                                                  const SizedBox(
                                                                      width:
                                                                          20.0),
                                                                  Expanded(
                                                                      child: DefaultButton(
                                                                          buttonColor: Constants.whiteDark,
                                                                          onPressed: () {
                                                                            Get.close(1);
                                                                          },
                                                                          child: const DefaultText(
                                                                            text:
                                                                                "Cancel",
                                                                            fontColor:
                                                                                Constants.whiteLight,
                                                                            size:
                                                                                16.0,
                                                                          ))),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: const DefaultText(
                                                  text: "Delete",
                                                  fontColor:
                                                      Constants.errorNormal,
                                                  size: 18.0,
                                                ),
                                              ),
                                              const SizedBox(width: 15.0),
                                              InkWell(
                                                onTap: () => Get.close(1),
                                                child: const DefaultText(
                                                  text: "Close",
                                                  size: 18.0,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                context: Get.context!)
                            : () => Get.toNamed(Routes.addNewCard),
                      ),
                    );
                  })),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
