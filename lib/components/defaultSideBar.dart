import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultDrawerItems.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/decide_route_controller.dart';
import 'package:apex_logistics/main.dart';
import 'package:apex_logistics/routes/routes.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultSideBar extends StatelessWidget {
  DefaultSideBar({super.key});

  final controller = Get.put(DecideRouteController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Constants.whiteNormal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SIDEBAR: Top-Section
          InkWell(
            onTap: () {
              Get.close(1);
              Get.toNamed(Routes.profile);
            },
            child: Container(
              width: size.width,
              height: size.height * 0.2,
              padding: const EdgeInsets.only(
                top: 100,
                left: 20,
                bottom: 50,
              ),
              decoration: const BoxDecoration(
                color: Constants.whiteLight,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/rider.jpg",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  const DefaultText(
                    text: "Profile",
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),

          // SIDEBAR: Middle Section
          Container(
            width: size.width,
            height: size.height * 0.4,
            decoration: const BoxDecoration(
              color: Constants.whiteLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Wrap(
                children: [
                  DefaultDrawerItems(
                    icon: Icons.account_balance_wallet,
                    text: "Payment",
                    onTap: () {
                      Get.close(1);
                      Get.toNamed(Routes.payment);
                    },
                  ),
                  DefaultDrawerItems(
                    icon: Icons.delivery_dining_rounded,
                    text: "My ride",
                    onTap: () => {
                      Navigator.pop(context),
                      Get.toNamed(Routes.myRide),
                    },
                  ),
                  sharedPreferences.getBool("driver")!
                      ? DefaultDrawerItems(
                          icon: Icons.delivery_dining_rounded,
                          text: "Requests",
                          onTap: () => {
                            Get.close(1),
                            // iDK sha, i believe there should be or linked with myRide route(above)
                            // Get.toNamed(Routes.myRide),
                          },
                        )
                      : const SizedBox.shrink(),
                  DefaultDrawerItems(
                    icon: Icons.badge,
                    text: "About Us",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // SIDEBAR: Bottom Section
          Container(
            width: size.width,
            height: size.height * 0.3,
            padding: const EdgeInsets.only(
              top: 100,
              left: 20,
              bottom: 50,
            ),
            decoration: const BoxDecoration(
              color: Constants.whiteLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultButton(
                    onPressed: () {
                      if (controller.isDriver.value) {
                        Navigator.pop(Get.context!);
                        FirebaseAuth.instance.signOut();
                      } else {
                        Navigator.pop(Get.context!);
                        FirebaseAuth.instance.signOut();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText(
                          text: (controller.isDriver.value)
                              ? "Become a User"
                              : "Become a Rider",
                          fontColor: Constants.whiteNormal,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        (controller.isDriver.value)
                            ? const Icon((Icons.person), size: 20)
                            : const Icon(Icons.delivery_dining_outlined,
                                size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
