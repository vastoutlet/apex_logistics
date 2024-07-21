import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/defaultText.dart';

class PaymentController extends GetxController {
  // Methods met = Methods.transfer;
  final RxList<Widget> paymentIcon = [
    Image.asset(
      "assets/images/plus_math.png",
      width: 20,
      height: 20,
    )
    // Icon(Icons.add),
  ].obs;

  final RxList<Widget> paymentMethod = [
    const DefaultText(
      text: "Add debit/credit card",
      size: 18.0,
    ),
  ].obs;
  RxString met = "method0".obs;

  void setDefaultPayment(int index) {
    met.value = "method$index";
  }
}
