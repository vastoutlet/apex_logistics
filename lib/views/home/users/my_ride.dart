import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/components/defaultRideCards.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class MyRide extends StatefulWidget {
  MyRide({super.key});

  @override
  State<MyRide> createState() => _MyRideState();
}

class _MyRideState extends State<MyRide> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      appBar: const DefaultAppBar(),
      key: scaffoldKey,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          child: Column(
            children: [
              DefaultRideCards(
                address: "6 Tudun wada Street, Bauchi",
                timePrice: "18 Jun, 10:45am ₦2,000",
                deliveryMessage: "Delivered Successful",
                status: true,
              ),
              DefaultRideCards(
                address: "6 Tudun wada Street, Bauchi",
                timePrice: "18 Jun, 10:45am ₦2,000",
                deliveryMessage: "Ongoing Ride",
                status: true,
              ),
              DefaultRideCards(
                address: "6 Tudun wada Street, Bauchi",
                timePrice: "18 Jun, 10:45am ₦2,000",
                deliveryMessage: "Canceled",
                status: false,
              ),
              DefaultRideCards(
                address: "6 Tudun wada Street, Bauchi",
                timePrice: "18 Jun, 10:45am ₦2,000",
                deliveryMessage: "Pending Ride",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
