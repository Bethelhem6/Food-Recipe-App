import 'package:flutter/material.dart';

import 'custom_dialog_box.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String primaryButtonText,
  required VoidCallback primaryButtonOnPressed,
  required String secondaryButtonText,
  required VoidCallback secondaryButtonOnPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        description: description,
        primaryButtonText: primaryButtonText,
        primaryButtonOnPressed: primaryButtonOnPressed,
        secondaryButtonText: 'Cancel',
        secondaryButtonOnPressed: secondaryButtonOnPressed,
      );
    },
  );
}
