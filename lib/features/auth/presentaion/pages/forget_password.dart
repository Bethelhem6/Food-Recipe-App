 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm/features/auth/presentaion/pages/login.dart';

import '../../../../core/utils/validators/password_validator.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/password_text_field.dart';
import '../../../../shared/presentation/widgets/show_success_message.dart';
import '../../domain/models/reset_password_param.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  static const String routeName = "ForgetPasswordScreen";
  const ForgetPasswordScreen({super.key, required this.phoneNumber});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordCntl = TextEditingController();
  TextEditingController confirmPasswordCntl = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  var focusNode = FocusNode();
  @override
  void dispose() {
    confirmPasswordCntl.dispose();
    newPasswordCntl.dispose();
    super.dispose();
  }

  void showDialogBox(BuildContext ctx, String content) {
    showDialog(
      context: ctx,
      builder: (tx) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.info),
              SizedBox(
                width: 20,
              ),
              Text("info"),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Okay"),
            )
          ],
        );
      },
    );
  }

  void resetPassword(BuildContext ctx) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ResetPasswordParam param = ResetPasswordParam(
        password: newPasswordCntl.text,
        phoneNumber: widget.phoneNumber,
        confirmPassword: confirmPasswordCntl.text,
      );
      context.read<AuthBloc>().add(
            AuthResetPassword(param: param),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (pd) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Forget Password",
        ) as PreferredSizeWidget,
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   margin: const EdgeInsets.symmetric(
                  //       horizontal: 0, vertical: 10),
                  //   child: Text(
                  //       language!.translate("tell_us_your_new_password"),
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold, fontSize: 18)),
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .04,
                        left: MediaQuery.of(context).size.width * .06,
                        right: MediaQuery.of(context).size.width * .06),
                    child: const CustomText(
                      title: "Tell us your new password",
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: MediaQuery.of(context).size.width * .07,
                        right: MediaQuery.of(context).size.width * .07),
                    child: const Text(
                      "A verification code will be sent to you",
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
                      title: "Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  PasswordTextField(
                    // focusNode: focusNodes[1],
                    hintText: "*********",
                    onFieldSubmit: (value) =>
                        FocusScope.of(context).requestFocus(focusNode),
                    changeVisibility: () => setState(() {
                      showPassword = !showPassword;
                    }),
                    controller: newPasswordCntl,
                    showPassword: showPassword,
                    // onFieldSubmit: (value) => submitLogin(),
                    validator: (value) =>
                        PasswordValidation.passwordValidator(value, context),
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
                    focusNode: focusNode,
                    hintText: "*********",
                    onFieldSubmit: (value) {
                      resetPassword(context);
                    },
                    changeVisibility: () => setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    }),
                    controller: confirmPasswordCntl,
                    showPassword: showConfirmPassword,
                    // onFieldSubmit: (value) => submitLogin(),
                    validator: (value) =>
                        PasswordValidation.confirmPasswordValidator(
                            value, context, newPasswordCntl),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),

                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is AuthResetPasswordFaulire) {
                      errorMessageHandler(context, state.failure.errorMessage);
                    }

                    if (state is AuthResetPasswordSuccess) {
                      DisplayMessage.show(
                          context, "The password has been successfully reset.");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        (_) => false,
                      );
                    }
                  }, builder: (context, state) {
                    return CustomButton(
                      isLoading: state is AuthResetPasswordLoading,
                      loadingText: "Please wait..",
                      onPressed: () {
                        resetPassword(context);
                      },
                      title: "Reset Passwrod",
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
