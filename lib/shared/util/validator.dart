// Project imports:
import 'package:flutter_boilerplate/shared/util/email_validator.dart';

class Validator {
  static bool isValidEmail(String? value) {
    if (value == null) {
      return false;
    }
    if (value.isEmpty) {
      return false;
    }
    if (value.length < 4) {
      return false;
    }

    return EmailValidator.validate(value);
  }

  static bool isValidPassWord(String? value) {
    if (value == null) {
      return false;
    }
    if (value.isEmpty) {
      return false;
    }
    if (value.length < 5) {
      return false;
    }

    return true;
  }
}
