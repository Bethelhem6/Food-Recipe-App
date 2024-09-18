import 'package:emebet/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String? value, TextEditingController controller) onChange;
  final Function(String? value) validater;
  final bool? editable;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmit;

  const PhoneNumberTextField({
    super.key,
    this.onFieldSubmit,
    this.editable,
    this.focusNode,
    this.textInputAction,
    required this.onChange,
    required this.controller,
    required this.validater,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        right: MediaQuery.of(context).size.width * .06,
        left: MediaQuery.of(context).size.width * .06,
      ),
      child: TextFormField(
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color.fromARGB(255, 48, 48, 48)),
        textInputAction: textInputAction,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) => validater(value),
        onFieldSubmitted: onFieldSubmit,
        onChanged: (value) => onChange(value, controller),
        controller: controller,
        maxLength: 9,
        decoration: InputDecoration(
            enabled: editable != false,
            // filled: true,
            // fillColor: Theme.of(context).hintColor,

            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.grey500,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            counterText: '',
            prefixIcon: Container(
              margin: const EdgeInsets.only(right: 3),
              decoration: const BoxDecoration(
                  color: Color(0xFF3A3838),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              width: 70,
              height: 60,
              alignment: Alignment.center,
              child: const Text(
                "+251",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            hintText: " 918-23-43-55",
            hintStyle: const TextStyle(
                color: AppColors.grey500,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.grey500,
                ),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
