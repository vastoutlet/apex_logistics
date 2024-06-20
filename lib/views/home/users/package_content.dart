import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultStepper.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PackageContent extends StatefulWidget {
  PackageContent({super.key});

  @override
  State<PackageContent> createState() => _PackageContentState();
}

class _PackageContentState extends State<PackageContent> {
  List<DefaultForm> parcelItemList = [
    const DefaultForm(
      icon: Icons.my_location,
      hintText: "item",
      fillColor: Constants.whiteDark,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                        text: "Package Content",
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
                          // Header : Items and Add item
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const DefaultText(
                                text: "Item(s) in the parcel",
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    parcelItemList.add(
                                      const DefaultForm(
                                        icon: Icons.my_location,
                                        hintText: "items",
                                        fillColor: Constants.whiteDark,
                                      ),
                                    );
                                  })
                                },
                                child: const DefaultText(
                                  text: "Add item",
                                  size: 20,
                                  weight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                          // Item FormField
                          for (int index = 0;
                              index < parcelItemList.length;
                              index++) ...[
                            Slidable(
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: ((context) {
                                        // delete textFormField
                                        setState(() {
                                          parcelItemList.removeAt(index);
                                        });
                                      }),
                                      backgroundColor: Constants.whiteNormal,
                                      foregroundColor: Constants.errorDark,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: parcelItemList[index],
                              ),
                            ),
                          ],

                          // Help text
                          if (parcelItemList.isNotEmpty)
                            const DefaultText(
                              text: "Swipe item fields to delete",
                              fontColor: Constants.blackNormal,
                              size: 15,
                            ),

                          // Add item
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 50),
                            child: DefaultButton(
                              onPressed: () {},
                              child: const DefaultText(
                                text: "Choose a rider",
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
