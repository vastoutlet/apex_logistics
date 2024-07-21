import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar defaultSnackBar({required bool tag, String? message}) {
  return GetSnackBar(
      messageText: Row(
        children: [
          tag
              ? const Icon(
                  Icons.check_circle,
                  color: Constants.primaryNormal,
                )
              : const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
          const SizedBox(width: 20.0),
          DefaultText(
            text: message,
            fontColor: tag ? Constants.primaryNormal : Colors.red,
            size: 18.0,
          ),
        ],
      ),
      backgroundColor: Constants.whiteLight,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(20.0),
      borderColor: tag ? Constants.primaryNormal : Colors.red,
      borderWidth: 1.0,
      borderRadius: 20);
}
