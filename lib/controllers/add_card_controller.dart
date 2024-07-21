import 'package:apex_logistics/components/defaultSnackBar2.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/payment_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:apex_logistics/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddNewCardController extends GetxController {
  var buttonColor = Constants.primaryNormal;
  RxBool isCardNumberNotEmpty = false.obs;
  RxBool isCVVNotEmpty = false.obs;
  RxBool isExpiryNotEmpty = false.obs;
  RxBool isButtonEnabled = false.obs;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  var cardTypeIcon = Rxn<Widget>();
  var paymentCard = PaymentCard().obs;

  final formKey = GlobalKey<FormState>();

  updatePaymentMethodList({String? cardNum, CardType? iconType}) {
    // update payment method list
    var paymentMethod = Get.find<PaymentController>();
    paymentMethod.paymentMethod.insert(
        0,
        DefaultText(
          text: "•••• $cardNum",
        ));
    paymentMethod.paymentIcon.insert(0, CardUtils.getCardIcon(iconType)!);
    paymentMethod.setDefaultPayment(0);
  }

  getCardTypeFrmNum() {
    String input = cardNumberController.text;
    // set card type icon
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    cardTypeIcon.value = CardUtils.getCardIcon(cardType);
    paymentCard.value.type = cardType;
  }

  saveCardDetails(context) {
    var isValid = formKey.currentState!.validate();
    if (!isValid) return;
    formKey.currentState!.save();

    print("collected data: ${paymentCard.value.toString()}");

    updatePaymentMethodList(
        cardNum: paymentCard.value.number!.substring(12, 16),
        iconType: paymentCard.value.type);

    Get.showSnackbar(
        defaultSnackBar(tag: true, message: "Card Details Successfully Added"));

    Get.close(1);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // set the card type
    cardTypeIcon.value = CardUtils.getCardIcon(CardType.Others);
    paymentCard.value.type = CardType.Others;
    cardNumberController.addListener(() {
      getCardTypeFrmNum();
      isCardNumberNotEmpty.value = cardNumberController.text.isNotEmpty;
    });

    cvvController.addListener(() {
      isCVVNotEmpty.value = cvvController.text.isNotEmpty;
    });

    expiryController.addListener(() {
      isExpiryNotEmpty.value = expiryController.text.isNotEmpty;
    });
  }
}

class PaymentCard {
  CardType? type;
  String? number;
  String? name;
  int? month;
  int? year;
  int? cvv;

  PaymentCard({
    this.type,
    this.number,
    this.name,
    this.month,
    this.year,
    this.cvv,
  });

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv]';
  }
}

enum CardType { Master, Visa, Verve, Others, Invalid }

class CardUtils {
  static Widget? getCardIcon(CardType? cardType) {
    String img = "";
    Widget? icon;
    // get card type
    switch (cardType) {
      case CardType.Master:
        img = "mastercard.png";
        break;
      case CardType.Visa:
        img = "visa.png";
        break;
      case CardType.Verve:
        img = "verve.png";
        break;
      case CardType.Others:
        icon = SvgPicture.asset(
          "assets/images/Magnetic_Card.svg",
          width: 20,
          height: 20,
        );

        break;
      default:
        icon = const Icon(
          Icons.warning,
          size: 40,
          color: Constants.errorLight,
        );
    }

    // select the appropriate image
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        "assets/images/$img",
        width: 40,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static getCleanedNumber(String value) {
    // regex of all character not 0-9
    RegExp exp = RegExp(r"[^0-9]");

    return value.replaceAll(exp, ''); //replace with empty string
  }

  static String? validateCardNum(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }

    value = getCleanedNumber(value); //clean provided card number

    if (value!.length <= 8) {
      return Strings.numberIsInvalid;
    }

    // using Luhn Algo
    int sum = 0;
    int length = value.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(value[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return Strings.numberIsInvalid;
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }

    int year;
    int month;

    // get the value and split in year and month
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      //only month was entered
      month = int.parse(value.substring(0, (value.length))); //get month num
      year = -1; //use an invalid year
    }

    if ((month < 1) || (month > 12)) {
      //month should be within 1-12
      return 'Invalid month';
    }

    var fourDigitsYear = convertYear24Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // assume a valid date is between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Invalid year';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }

    return null;
  }

  static int convertYear24Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and month has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case,
    //    assume that the month has passed
    // 2. Card's month  is more than current month (plus the next month).
    return hasYearPassed(year) ||
        convertYear24Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYear24Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's year
    return fourDigitsYear < now.year;
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }
}
