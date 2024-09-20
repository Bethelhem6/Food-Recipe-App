 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../../core/utils/log/app_logger.dart';
import '../../../../core/utils/validators/password_validator.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/password_text_field.dart';
import '../../domain/models/change_password_param.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "change_password";
  const ChangePassword({super.key});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordCntl = TextEditingController();
  TextEditingController newPasswordCntl = TextEditingController();
  TextEditingController confirmPasswordCntl = TextEditingController();
  var currentFocus = FocusNode();
  var newFocus = FocusNode();
  var confirmFocus = FocusNode();
  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showconfirmPassword = false;
  void showDialogBox(BuildContext ctx, String content) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (tx) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.info),
              SizedBox(
                width: 20,
              ),
              Text("Info"),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            )
          ],
        );
      },
    );
  }

  void changePassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        formSubmitted = true;
      });
      ChangePasswordParam param = ChangePasswordParam(
          confirmPassword: newPasswordCntl.text,
          currentPassword: currentPasswordCntl.text,
          password: newPasswordCntl.text);
      BlocProvider.of<AuthBloc>(context).add(AuthUpdatePassword(param: param));
    }
  }

  bool formSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (pd) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar:
            const CustomAppBar(title: "Change Password") as PreferredSizeWidget,
        body: ListView(
          children: [
            Form(
              key: _formKey,
              autovalidateMode:
                  formSubmitted ? AutovalidateMode.onUserInteraction : null,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          right: MediaQuery.of(context).size.width * .06,
                          left: MediaQuery.of(context).size.width * .06,
                        ),
                        child: const CustomText(
                          title: "Let's chnage your password",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
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
                        title: "Current password",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    PasswordTextField(
                      focusNode: currentFocus,
                      hintText: "*********",
                      changeVisibility: () => setState(() {
                        showCurrentPassword = !showCurrentPassword;
                      }),
                      onFieldSubmit: (value) =>
                          FocusScope.of(context).requestFocus(newFocus),
                      controller: currentPasswordCntl,
                      showPassword: showCurrentPassword,
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
                        title: "New password",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    PasswordTextField(
                      focusNode: newFocus,
                      hintText: "*********",
                      changeVisibility: () => setState(() {
                        showNewPassword = !showNewPassword;
                      }),
                      onFieldSubmit: (value) =>
                          FocusScope.of(context).requestFocus(confirmFocus),
                      controller: newPasswordCntl,
                      showPassword: showNewPassword,
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
                      focusNode: confirmFocus,
                      hintText: "*********",
                      changeVisibility: () => setState(() {
                        showconfirmPassword = !showconfirmPassword;
                      }),
                      onFieldSubmit: (value) => changePassword(),
                      controller: confirmPasswordCntl,
                      showPassword: showconfirmPassword,
                      // onFieldSubmit: (value) => submitLogin(),
                      validator: (value) =>
                          PasswordValidation.confirmPasswordValidator(
                              value, context, newPasswordCntl),
                    ),
                    ////////
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),

                    BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                      logger.info(state);
                      if (state is AuthUpdatePasswordSuccess) {
                        PanaraInfoDialog.show(
                          context,
                          message:
                              'Congratulations! Your password has been successfully changed.',
                          buttonText: "Okay",
                          onTapDismiss: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          panaraDialogType: PanaraDialogType.success,
                        );
                      }
                      if (state is AuthUpdatePasswordFaulire) {
                        errorMessageHandler(
                          context,
                          state.failure.errorMessage,
                        );
                      }
                    }, builder: (context, state) {
                      return CustomButton(
                        isLoading: state is AuthUpdatePasswordLoading,
                        onPressed: () {
                          if (state is! AuthUpdatePasswordLoading) {
                            changePassword();
                          }
                        },
                        loadingText: "please wait...",
                        title: "Change Password",
                      );
                    })
                    // }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
