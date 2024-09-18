import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Validators {
  static String? nameValidator(String? value, BuildContext context) {
    String name = value.toString();
    if (name.isEmpty) {
      return 'Name must not empty';
    }
    if (name.length < 2) {
      return "Name lenght must not less than 2";
    }

    return null;
  }

  static String? emailValidator(String? value, BuildContext context,
      {bool? isRequired}) {
    if (isRequired == false && value.toString().isEmpty) {
      return null;
    }
    if (value == null) {
      return "Email must not empty";
    } else if (value.isEmpty) {
      return "Email must not empty";
    } else if (!EmailValidator.validate(value.toString().trim())) {
      return 'Invalid Email';
    }
    return null;
  }
}
