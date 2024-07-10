import 'dart:async';

import 'package:apex_logistics/utils/strings.dart';
import 'package:intl_phone_field/phone_number.dart';

class FormValidator {
  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    } else if (value.length != 11) {
      return Strings.phoneIsInvalid;
    }
    return null;
  }


}
