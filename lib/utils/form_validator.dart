import 'package:apex_logistics/utils/strings.dart';

class FormValidator {
  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.fieldReq;
    }
    return null;
  }
}
