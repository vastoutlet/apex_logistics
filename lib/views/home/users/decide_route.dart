import 'package:apex_logistics/components/defaultAppBar2.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultSideBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/components/showTripModals.dart';
import 'package:apex_logistics/controllers/decide_route_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';

class DecideRoute extends StatelessWidget {
  DecideRoute({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = Get.put(DecideRouteController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: [
              // MAP
              Image.asset(
                "assets/images/map-blueprint2.png",
                fit: BoxFit.fill,
                height: size.height,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // APP BAR
                      Row(
                        children: [
                          DefaultAppBar2(
                            backgroundColor: Constants.whiteLight,
                            iconColor: Constants.blackDark,
                            icon: Icons.menu,
                            onPressed: () =>
                                scaffoldKey.currentState!.openDrawer(),
                          ),
                          SizedBox(width: size.width / 4),
                          controller.onlineCard.value
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Constants.whiteLight),
                                  child: const DefaultText(
                                    text: "Online",
                                    fontColor: Constants.primaryNormal,
                                    size: 18,
                                    weight: FontWeight.w700,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),

                      // Current Location
                      controller.isDriver.value
                          ? const SizedBox.shrink()
                          : const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: DefaultForm(
                                    icon: Icon(Icons.my_location),
                                    hintText: "Current Location",
                                  ),
                                ),

                                // Destination
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: DefaultForm(
                                    icon: Icon(Icons.location_on),
                                    hintText: "Destination",
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
          drawer: DefaultSideBar(),
          bottomSheet: controller.onlineCard.value
              ? const SizedBox.shrink()
              : Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Constants.whiteLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 20),
                    child: controller.isDriver.value
                        ? SizedBox(
                            height: 70.0,
                            child: SlideAction(
                              trackBuilder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Constants.whiteDark,
                                  ),
                                  child: Center(
                                    child: DefaultText(
                                      // Show loading if async operation is being performed
                                      text: state.isPerformingAction
                                          ? "Loading..."
                                          : "Go Online",
                                      fontColor: Constants.whiteLight,
                                      size: 18.0,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              thumbBuilder: (context, state) {
                                return Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Constants.whiteLight,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    // Show loading indicator if async operation is being performed
                                    child: state.isPerformingAction
                                        ? const CupertinoActivityIndicator(
                                            color: Constants.whiteDark,
                                          )
                                        : const Icon(
                                            Icons.chevron_right,
                                            color: Constants.whiteDark,
                                            size: 30.0,
                                          ),
                                  ),
                                );
                              },
                              action: () async {
                                // toggle driver status from remote
                                await Future.delayed(
                                  const Duration(seconds: 2),
                                  () => controller.onlineCard.value = true,
                                );
                              },
                            ))
                        : DefaultButton(
                            onPressed: () =>
                                showTripModals(context, ConfirmAddress()),
                            child: const DefaultText(
                              text: "Create Trip",
                              fontColor: Constants.whiteNormal,
                              size: 18,
                            ),
                          ),
                  ),
                ),
        ));
  }
}
