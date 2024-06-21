import 'package:apex_logistics/components/defaultAppBar.dart';
import 'package:apex_logistics/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      appBar: DefaultAppBar(
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Column(
            children: [
              // APPBAR
            ],
          ),
        ),
      ),
    );
  }
}
