import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/validators/password_validator.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/password_text_field.dart';
import '../../domain/models/auth_use_case.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class PasswordScreen extends StatefulWidget {
  static const String routeName = "PasswordScreen";
  final RegistrationParam registrationParam;
  const PasswordScreen({super.key, required this.registrationParam});
  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isNextButtonClicked = false;

  bool showCreatePassword = false;
  bool showConfirmPassword = false;
  final confirmFocus = FocusNode();

  @override
  void dispose() {
    passwordController.dispose();
    confirmFocus.dispose();
    super.dispose();
  }

  void submitPassword() {
    try {
      setState(() {
        isNextButtonClicked = true;
      });
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();

        widget.registrationParam.password = passwordController.text;
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (pd) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Password") as PreferredSizeWidget,
        body: ListView(
          children: [
            Form(
              autovalidateMode: isNextButtonClicked
                  ? AutovalidateMode.onUserInteraction
                  : null,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .03),
                    // margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 10,
                              left: MediaQuery.of(context).size.width * .06,
                              right: MediaQuery.of(context).size.width * .06),
                          child: const CustomText(
                            title:
                                "Create a secure password to protect your account",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: MediaQuery.of(context).size.width * .06,
                              right: MediaQuery.of(context).size.width * .07),
                          child: const Text(
                            " A strong password helps keep your information safe and secure.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            right: MediaQuery.of(context).size.width * .06,
                            left: MediaQuery.of(context).size.width * .06,
                          ),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const CustomText(
                            title: "password",
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        PasswordTextField(
                          hintText: "*********",
                          changeVisibility: () => setState(() {
                            showCreatePassword = !showCreatePassword;
                          }),
                          controller: passwordController,
                          showPassword: showCreatePassword,
                          onFieldSubmit: (value) =>
                              FocusScope.of(context).requestFocus(confirmFocus),
                          validator: (value) =>
                              PasswordValidation.passwordValidator(
                                  value, context),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            right: MediaQuery.of(context).size.width * .06,
                            left: MediaQuery.of(context).size.width * .06,
                          ),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const CustomText(
                            title: "Confirm password",
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        PasswordTextField(
                          focusNode: confirmFocus,
                          // focusNode: focusNodes[1],
                          onFieldSubmit: (value) => submitPassword(),
                          hintText: "*********",
                          changeVisibility: () => setState(() {
                            showCreatePassword = !showCreatePassword;
                          }),
                          controller: confirmPasswordController,
                          showPassword: showCreatePassword,
                          // onFieldSubmit: (value) => submitLogin(),
                          validator: (value) =>
                              PasswordValidation.confirmPasswordValidator(
                                  value, context, passwordController),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .05,
                          right: MediaQuery.of(context).size.width * .1,
                          left: MediaQuery.of(context).size.width * .1,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  style: TextStyle(
                                      color: Color(0xffADADAD),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  text:
                                      "By clicking 'Create Account,' you acknowledge that you have read and agreed to  Mvvm's "),
                              TextSpan(
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                text: "Terms of Usage",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              const TextSpan(
                                style: TextStyle(
                                    color: Color(0xffADADAD),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                text: " and ",
                              ),
                              TextSpan(
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                text: "Privacy policy",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                        if (state is AuthRegisterParentSuccess) {
                          // Navigator.pushNamedAndRemoveUntil(context,
                          //     RegistrationSuccess.routeName, (_) => false,
                          //     arguments: widget.registrationParam);
                        }
                        if (state is AuthRegisterParentFaulire) {
                          errorMessageHandler(
                            context,
                            state.failure.errorMessage,
                          );
                        }
                      }, builder: (context, state) {
                        return CustomButton(
                          isLoading: state is AuthRegisterParentLoading,
                          loadingText: "Please wait...",
                          onPressed: submitPassword,
                          title: "Creating Account",
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
