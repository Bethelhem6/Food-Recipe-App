import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final bool showPassword;
  final String hintText;
  final TextEditingController controller;
  final Function(String? value) validator;
  final Function changeVisibility;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmit;
  const PasswordTextField({
    super.key,
    this.focusNode,
    this.onFieldSubmit,
    this.textInputAction,
    required this.changeVisibility,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.showPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
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
        validator: (value) => validator(value),
        onFieldSubmitted: onFieldSubmit,
        controller: controller,
        maxLength: 25,
        obscureText: !showPassword,
        decoration: InputDecoration(
            counterText: '',
            fillColor: Theme.of(context).hintColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2,
                    color: Color(0xffE0E0E0),
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10)),
            suffixIcon: IconButton(
              icon: Icon(!showPassword
                  ? Icons.visibility_off
                  : Icons.visibility_sharp),
              onPressed: () => changeVisibility(),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                color: const Color(0xffBDBDBD).withOpacity(.4),
                fontSize: 16,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color(0xffE0E0E0), style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
