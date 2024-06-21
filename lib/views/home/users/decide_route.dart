import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultAppBar2.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultSideBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/components/showTripModals.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/views/home/users/confirm_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DecideRoute extends StatefulWidget {
  DecideRoute({super.key});

  @override
  State<DecideRoute> createState() => _DecideRouteState();
}

class _DecideRouteState extends State<DecideRoute> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
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
                      icon: Icons.my_location,
                      hintText: "Current Location",
                    ),
                  ),

                  // Destination
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: DefaultForm(
                      icon: Icons.location_on,
                      hintText: "Destination",
                    ),
                  ),
                ],
              ),
            ),
          ],
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
