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
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class DecideRoute extends StatefulWidget {
  const DecideRoute({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
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
          },
          child: Stack(
            children: [
              // MAP
              Image.asset(
                "assets/images/map.png",
                fit: BoxFit.fill,
                height: size.height,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // APP BAR
                    DefaultAppBar2(
                      backgroundColor: Constants.whiteLight,
                      iconColor: Constants.blackDark,
                      icon: Icons.menu,
                      onPressed: () => scaffoldKey.currentState!.openDrawer(),
                    ),

                    // Current Location
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DefaultForm(
                        icon: Icon(Icons.my_location),
                        hintText: "Current Location",
                      ),
                    ),

                    // Destination
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DefaultForm(
                        icon: Icon(Icons.location_on),
                        hintText: "Destination",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const DefaultSideBar(),
      bottomSheet: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Constants.whiteLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: DefaultButton(
            onPressed: () => showTripModals(context, ConfirmAddress()),
            child: const DefaultText(
              text: "Create Trip",
              fontColor: Constants.whiteNormal,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
