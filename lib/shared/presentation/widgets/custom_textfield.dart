import '../../../core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function()? onTap;
  final Widget? prefixIcon;
  final bool isRequired;
  final String name;
  final Function(String? value) validator;
  final Function(String? value)? onChange;
  final int? maxLength;
  final int? maxLines;
  final bool? showCounterText;
  final bool? isonlyNumber;
  final bool? editable;
  final bool? takeSpaceAlphabetsNumber;
  final TextInputAction? textInputAction;
  final bool? isEmail;
  final bool? takeBothNumberAndAlphabets;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmit;

  const CustomTextField(
      {super.key,
      this.onFieldSubmit,
      this.editable,
      this.showCounterText,
      this.onTap,
      this.prefixIcon,
      this.maxLines,
      this.takeBothNumberAndAlphabets,
      this.isEmail,
      this.focusNode,
      this.textInputAction,
      required this.isRequired,
      required this.hintText,
      required this.controller,
      required this.name,
      required this.validator,
      this.onChange,
      this.isonlyNumber,
      this.takeSpaceAlphabetsNumber,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (name.isNotEmpty)
          Container(
              margin: EdgeInsets.only(
                top: 10,
                right: MediaQuery.of(context).size.width * .06,
                left: MediaQuery.of(context).size.width * .06,
              ),
              child: Text.rich(
                TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blackBold,
                  ),
                  children: <TextSpan>[
                    if (isRequired)
                      const TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFF0C0C),
                        ),
                      ),
                  ],
                ),
              )),
        Container(
          margin: EdgeInsets.only(
            top: 5,
            right: MediaQuery.of(context).size.width * .06,
            left: MediaQuery.of(context).size.width * .06,
          ),
          // height: 56,
          child: TextFormField(
            onTap: onTap,
            enabled: editable,
            onChanged: onChange,
            focusNode: focusNode,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmit,
            validator: (value) => validator(value),
            inputFormatters: <TextInputFormatter>[
              if (takeSpaceAlphabetsNumber == true)
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[A-Za-z0-9 _]*[A-Za-z0-9][A-Za-z0-9 _]*$')),
              if (isonlyNumber == true && takeBothNumberAndAlphabets != true)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              if (isonlyNumber != true &&
                  isEmail != true &&
                  takeBothNumberAndAlphabets != true &&
                  takeSpaceAlphabetsNumber != true)
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
              if (takeBothNumberAndAlphabets == true)
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),

              // FilteringTextInputFormatter.allow(RegExp(r' [a-zA-Z0-9\s]+$')),
            ],
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color.fromARGB(255, 48, 48, 48)),
            controller: controller,
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 17.0, horizontal: 10.0),
                enabled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.grey400,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                // filled: true,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: const Color(0xffBDBDBD).withOpacity(.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xffE0E0E0), style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
      ],
    );
  }
}
