import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultSnackBar2.dart';
import 'package:apex_logistics/components/defaultStepper.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/components/showTripModals.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/home/users/chooseRider.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class DeliveryInfo extends StatefulWidget {
  DeliveryInfo({super.key});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  List<DefaultForm> parcelItemList = [
    const DefaultForm(
      icon: Icon(Icons.card_giftcard_rounded),
      hintText: "item",
      fillColor: Constants.whiteDark,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addressController = Get.find<ConfirmAddressController>();
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: IntrinsicHeight(
          child: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Confirm address and Stepper
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stepper Title
                      DefaultText(
                        text: "Delivery Info",
                        fontColor: Constants.whiteNormal,
                        size: 20,
                        weight: FontWeight.bold,
                      ),

                      // Stepper Row
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: DefaultStepper(step: 2),
                      ),
                    ],
                  ),
                ),

                // Current Trip
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Constants.whiteNormal,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Note
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "Note:",
                                style: TextStyle(
                                    color: Constants.blackNormal,
                                    fontFamily: "RobotoRegular",
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    " All item will be confirmed before the rider take of and also make sure the ",
                                style: TextStyle(
                                  color: Constants.blackNormal,
                                  fontFamily: "RobotoRegular",
                                )),
                            TextSpan(
                                text: "Receiver ",
                                style: TextStyle(
                                    color: Constants.blackNormal,
                                    fontFamily: "RobotoRegular",
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " is active to receive the package",
                                style: TextStyle(
                                  color: Constants.blackNormal,
                                  fontFamily: "RobotoRegular",
                                )),
                          ])),
                          const SizedBox(height: 10.0),

                          // Delivery Info for each location selected
                          for (int index = 0;
                              index <
                                  addressController.stepperDataTitle.length - 1;
                              index++) ...[
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Constants.primaryNormal)),
                              child: ExpansionTile(
                                  childrenPadding: const EdgeInsets.all(5),
                                  title: DefaultText(
                                    size: 18.0,
                                    text: index == 0
                                        ? addressController.stepperDataTitle
                                            .elementAt(index + 1)
                                        : addressController.stepperDataTitle
                                            .elementAt(index),
                                  ),
                                  children: [
                                    //form for receiver details
                                    Form(
                                        child: Column(
                                      children: [
                                        const DefaultForm(
                                          hintText: "Receiver Name",
                                          fillColor: Constants.whiteDark,
                                        ),
                                        const SizedBox(height: 5.0),
                                        DefaultForm(
                                          hintText: "Receiver Phone Number",
                                          fillColor: Constants.whiteDark,
                                          keyboardType: TextInputType.phone,
                                          inputFormatter: [
                                            LengthLimitingTextInputFormatter(11)
                                          ],
                                        ),
                                        const SizedBox(height: 5.0),
                                        GestureDetector(
                                          onTap: () => setState(() {
                                            parcelItemList.add(
                                              const DefaultForm(
                                                icon: Icon(Icons
                                                    .card_giftcard_rounded),
                                                hintText: "item",
                                                fillColor: Constants.whiteDark,
                                              ),
                                            );
                                          }),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Help text
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Row(
                                                    children: [
                                                      if (parcelItemList
                                                          .isNotEmpty)
                                                        const DefaultText(
                                                          text:
                                                              "swipe item fields to delete",
                                                          fontColor: Constants
                                                              .errorNormal,
                                                          size: 13,
                                                          style:
                                                              FontStyle.italic,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                  Icons
                                                      .add_circle_outline_outlined,
                                                  color:
                                                      Constants.primaryNormal),
                                              const SizedBox(width: 5.0),
                                              const DefaultText(
                                                  text: "Add Item")
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        for (var itemField = 0;
                                            itemField < parcelItemList.length;
                                            itemField++) ...[
                                          Slidable(
                                            endActionPane: ActionPane(
                                                motion: const ScrollMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: ((context) {
                                                      // delete textFormField
                                                      setState(() {
                                                        if (parcelItemList
                                                                .length ==
                                                            1) {
                                                          Get.showSnackbar(
                                                              defaultSnackBar(
                                                                  tag: false,
                                                                  message:
                                                                      "There must be at least one item"));
                                                        } else {
                                                          parcelItemList
                                                              .removeAt(
                                                                  itemField);
                                                        }
                                                      });
                                                    }),
                                                    backgroundColor:
                                                        Constants.whiteNormal,
                                                    foregroundColor:
                                                        Constants.errorDark,
                                                    icon: Icons.delete,
                                                    label: 'Delete',
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: parcelItemList[itemField],
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                        ],
                                      ],
                                    ))
                                  ]),
                            )
                          ],

                          //Add Delivery Info Button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 30),
                            child: DefaultButton(
                              onPressed: () {
                                navigator!.pop(Get.context!);

                                showTripModals(context, ChooseRider());
                              },
                              child: const DefaultText(
                                text: "Add delivery info",
                                fontColor: Constants.whiteNormal,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
