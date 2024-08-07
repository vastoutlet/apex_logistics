import 'package:apex_logistics/components/defaultAppBar2.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultSideBar.dart';
import 'package:apex_logistics/components/defaultSnackBar2.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/components/showTripModals.dart';
import 'package:apex_logistics/controllers/decide_route_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_action/slide_action.dart';

// dashboard bottomsheet
class DraggableController extends GetxController {
  Rx<DraggableScrollableController> draggableScrollableController =
      DraggableScrollableController().obs;

  RxDouble size = 0.3.obs;

  RxBool locationLoader = false.obs;
  RxBool locationListTog = false.obs;

  nearbyLocationList() {
    Future.delayed(const Duration(seconds: 2), () {
      locationLoader.value = false;
      locationListTog.value = true;
    });
  }

  @override
  void onInit() {
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((_) { //to be sure
    draggableScrollableController.value.addListener(() {
      size.value = draggableScrollableController.value.size;
    });
    // });

    ever(locationLoader, (loader) {
      if (loader) {
        nearbyLocationList();
      }
    });
  }
}

class DecideRoute extends StatelessWidget {
  DecideRoute({super.key});

  final controller = Get.put(DecideRouteController());
  final confirmAddressController = Get.put(ConfirmAddressController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime timeBackPressed = DateTime.now();
  final dragController = Get.put(DraggableController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: Constants.whiteLight,
          key: scaffoldKey,
          body: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (dragController.size.value == 1.0) {
                //not working as expected sha, lol
                dragController.draggableScrollableController.value.animateTo(
                    0.3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              } else {
                final difference = DateTime.now().difference(timeBackPressed);
                final isExitWarning = difference >= const Duration(seconds: 2);
                timeBackPressed = DateTime.now();

                if (didPop) {
                  return;
                }

                if (isExitWarning) {
                  showToast(
                    'Press back again to exit',
                    context: context,
                    animation: StyledToastAnimation.slideFromTopFade,
                    position: StyledToastPosition.top,
                  );
                } else {
                  SystemNavigator.pop();
                }
              }
            },
            child: Stack(
              children: [
                // MAP
                Image.asset(
                  "assets/images/map-blueprint2.png",
                  fit: BoxFit.fill,
                  height: size.height,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DefaultAppBar2(
                        backgroundColor: Constants.whiteLight,
                        iconColor: Constants.blackDark,
                        icon: Icons.menu,
                        onPressed: () => scaffoldKey.currentState!.openDrawer(),
                      ),
                      SizedBox(width: size.width / 10),
                      if (controller.isDriver.value) ...[
                        if (controller.isDriverOnline.value) ...[
                          SizedBox(
                              width: size.width / 1.5,
                              height: 55.0,
                              child: onlineStatusTogg(
                                  caption: "Go Offline",
                                  backgroundColor: Constants.blackLight,
                                  action: () {}))
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Constants.whiteLight),
                            child: const DefaultText(
                              text: "Offline",
                              fontColor: Constants.whiteDark,
                              size: 18,
                              weight: FontWeight.w700,
                            ),
                          )
                        ],
                      ],
                    ],
                  ),
                ),
                // Current Location - for other users
                if (!controller.isDriver.value) ...[
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Obx(
                        () => DraggableScrollableSheet(
                            controller: dragController
                                .draggableScrollableController.value,
                            // snap: true,
                            maxChildSize: 1.0,
                            initialChildSize: 0.3,
                            minChildSize: 0.3,
                            // expand: false,
                            builder: (context, scrollController) {
                              var dragger = dragController
                                  .draggableScrollableController.value;
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Constants.whiteLight,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: SizedBox(
                                    width: size.width,
                                    height: size.height / 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Column(
                                        children: [
                                          Obx(() {
                                            if (dragController.size.value ==
                                                0.3) {
                                              return Center(
                                                child: Container(
                                                  width: size.width / 6,
                                                  height: 4,
                                                  margin: const EdgeInsets.only(
                                                      top: 5.0, bottom: 10.0),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Constants.whiteDark,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                ),
                                              );
                                            } else if (dragController
                                                    .size.value ==
                                                1.0) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            dragger.animateTo(
                                                                0.3,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            100),
                                                                curve: Curves
                                                                    .bounceInOut);
                                                          },
                                                          child: const Icon(
                                                              Icons
                                                                  .arrow_back)),
                                                      const Expanded(
                                                        child: Center(
                                                          child: DefaultText(
                                                            text: "Where to?",
                                                            weight:
                                                                FontWeight.bold,
                                                            size: 18.0,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20.0)
                                                ],
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          }),
                                          const DefaultForm(
                                            icon: Icon(Icons.my_location),
                                            hintText: "Current Location",
                                          ),
                                          const SizedBox(height: 10.0),
                                          DefaultForm(
                                              onTap: () {
                                                if (dragger.size <= 0.3) {
                                                  dragger.animateTo(1.0,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.bounceIn);
                                                }
                                              },
                                              icon:
                                                  const Icon(Icons.location_on),
                                              hintText: "Destination",
                                              onChanged: (value) {
                                                if (value!.length > 1) {
                                                  dragController.locationLoader
                                                      .value = true;
                                                } else {
                                                  dragController.locationLoader
                                                      .value = false;
                                                  dragController.locationListTog
                                                      .value = false;
                                                }
                                              }),
                                          const SizedBox(height: 8.0),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_outlined,
                                                color: Constants.primaryNormal,
                                              ),
                                              SizedBox(width: 5.0),
                                              DefaultText(text: "Add Stops"),
                                            ],
                                          ),
                                          const SizedBox(height: 20.0),
                                          Obx(() {
                                            if (dragController.size.value ==
                                                0.3) {
                                              return DefaultButton(
                                                onPressed: () => showTripModals(
                                                    context, ConfirmAddress()),
                                                child: const DefaultText(
                                                  text: "Create Trip",
                                                  fontColor:
                                                      Constants.whiteNormal,
                                                  size: 18,
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          }),
                                          Obx(() {
                                            if (dragController
                                                .locationLoader.value) {
                                              return Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.grey,
                                                    ),
                                                    width: size.width,
                                                    height: 20.0,
                                                  ));
                                            } else if (dragController
                                                .locationListTog.value) {
                                              return Expanded(
                                                //update the location list
                                                child: ListTile(
                                                  onTap: () {
                                                    // confirmAddressController
                                                    //     .clearLocations();

                                                    confirmAddressController
                                                        .updateLocation("Niger",
                                                            "Niger Address"); //to be changed to use .add if location is multiple

                                                    Get.showSnackbar(
                                                        defaultSnackBar(
                                                            tag: true,
                                                            message:
                                                                "Location added to list, \n press the arrow key to continue "));
                                                  },
                                                  title: const DefaultText(
                                                    text: "Niger",
                                                    weight: FontWeight.bold,
                                                  ),
                                                  subtitle: const DefaultText(
                                                    text: "distance",
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )),
                ],
              ],
            ),
          ),
          drawer: DefaultSideBar(),
          bottomSheet: controller.isDriver.value
              ? controller.isDriverOnline.value
                  ? controller.driverStats(size)
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
                          child: SizedBox(
                              //go online button
                              height: 60.0,
                              child: onlineStatusTogg(
                                  caption: "Go Online",
                                  backgroundColor: Constants.whiteDark,
                                  action: () async {
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        controller.onlineCard.value =
                                            !controller.isDriverOnline.value;
                                        controller.isDriverOnline.value =
                                            !controller.isDriverOnline.value;
                                      },
                                    );
                                  }))),
                    )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  SlideAction onlineStatusTogg(
      {required String caption,
      required Color backgroundColor,
      required Function()? action}) {
    return SlideAction(
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Constants.primaryNormal),
          child: Center(
            child: DefaultText(
              // Show loading if async operation is being performed
              text: caption,
              fontColor: Constants.whiteLight,
              size: 18.0,
              weight: FontWeight.bold,
            ),
          ),
        );
      },
      thumbBuilder: (context, state) {
        final stackSize = MediaQuery.of(context).size;
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 4,
                top: 4,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: Constants.whiteLight,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                // Show loading indicator if async operation is being performed
                child: state.isPerformingAction
                    ? const CupertinoActivityIndicator(
                        color: Constants.whiteDark,
                      )
                    : Icon(
                        Icons.chevron_right,
                        color: backgroundColor,
                        size: 40.0,
                      ),
              ),
            ),
            Positioned.fill(
              left: stackSize.width * .13,
              child: Icon(
                Icons.chevron_right,
                color: backgroundColor,
                size: 20.0,
              ),
            ),
            Positioned.fill(
              left: stackSize.width * .14,
              child: Icon(
                Icons.chevron_right,
                color: backgroundColor,
                size: 30.0,
              ),
            ),
          ],
        );
      },
      action: action,
    );
  }
}
