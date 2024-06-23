import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCardController extends GetxController {
  var buttonColor = Constants.primaryNormal;
  RxBool isCardNumberNotEmpty = false.obs;
  final TextEditingController cardNumberController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cardNumberController.addListener(() {
      isCardNumberNotEmpty.value = cardNumberController.text.isNotEmpty;
    });
  }
}
