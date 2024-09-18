import 'package:flutter/material.dart';

void phoneNumberOnChange(String? value, TextEditingController controller) {
  final cleanedText = value.toString().replaceAll('-', '');
  final groups = _splitIntoGroups(cleanedText, 3);
  final groupedText = groups.join('-');
  controller.value = controller.value.copyWith(
    text: groupedText,
    selection: TextSelection.collapsed(
      offset: groupedText.length,
    ),
  );
}

List<String> _splitIntoGroups(String text, int groupSize) {
  final groups = <String>[];

  for (int i = 0; i < text.length; i += groupSize) {
    final group = text.substring(
        i, i + groupSize >= text.length ? text.length : i + groupSize);
    groups.add(group);
    // }
  }
  return groups;
}

String? phoneNumberValidator(value, BuildContext context) {
  String phone = value.toString().replaceAll("-", "");
  if (phone.isEmpty) {
    return 'Phone number must not be empty';
  }
  if (!(phone.startsWith('9') || phone.startsWith('7'))) {
    return 'Phone number must start with 9 or 7';
  } else if (phone.length < 9) {
    return 'Phone number must not be less than 9';
  }

  return null;
}
