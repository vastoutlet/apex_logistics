import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

void showTripModals(BuildContext context, Widget tripWidget,
    {Color? bgColor = Constants.primarydark}) {
  showModalBottomSheet(
    showDragHandle: true,
    enableDrag: true,
    backgroundColor: bgColor,
    isScrollControlled: true,
    isDismissible: false,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          child: tripWidget,
        ),
      );
    },
  );
}
