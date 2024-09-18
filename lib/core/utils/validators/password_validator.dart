import 'package:flutter/material.dart';

class PasswordValidation {
  static String? passwordValidator(value, BuildContext context) {
    String pass = value.toString();
    if (pass.isEmpty) {
      return 'Please enter password';
    } else if (pass.length <= 3) {
      return 'Password length must not be less than 4 symbols';
    }
    return null;
  }

  static String? confirmPasswordValidator(
      value, BuildContext context, TextEditingController controller) {
    String pass = value.toString();
    if (pass != controller.text) {
      return 'The entered passwords do not match';
    }
    return null;
  }
}
