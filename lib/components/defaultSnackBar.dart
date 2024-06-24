import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void defaultSnackBar(BuildContext context, bool isSuccess, String message) {
  Future.microtask(() {
    showTopSnackBar(
      Overlay.of(context),
      isSuccess
          ? CustomSnackBar.success(
              message: message,
              backgroundColor: Constants.primaryNormal,
            )
          : CustomSnackBar.error(
              message: message,
              backgroundColor: Constants.errorNormal,
            ),
    );
  });
}
