import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm/features/auth/presentaion/pages/login.dart';
import 'package:mvvm/features/auth/presentaion/pages/verification.dart';

import '../../../../core/utils/log/app_logger.dart';
import '../../../../core/utils/validators/phone_number_validator.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/phone_number_text_field.dart';
import '../../domain/models/auth_use_case.dart';
import '../../domain/models/screen_arguments.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "SignupScreen";
  final RegisterArguments registerArguments;

  const SignupScreen({super.key, required this.registerArguments});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  String verificationId = '';
  bool isLoading = false;
  bool isNextBottonPressed = false;
  void gotoVerificationScreen() {
    ConfirmOtpArguments registrationParam = ConfirmOtpArguments(
      isfromSignup: widget.registerArguments.fromScreen == "signup",
      recievedverificationId: verificationId,
      phoneNumber: "+251${phoneNumberController.text.replaceAll("-", '')}",
    );
    Navigator.pushNamed(
      context,
      VerificationScreen.routeName,
      arguments: registrationParam,
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Future authenticatePhone(BuildContext ctx) async {
    try {
      verificationComplete(AuthCredential credential) async {}
      await auth.verifyPhoneNumber(
        phoneNumber: "+251${phoneNumberController.text.replaceAll("-", '')}",
        timeout: const Duration(seconds: 100),
        verificationCompleted: verificationComplete,
        verificationFailed: (FirebaseAuthException e) {
          logger.info(e.message ?? "");
          setState(() {
            isLoading = false;
          });
          showDialog(
            context: ctx,
            builder: (ctx) {
              return AlertDialog(
                title: const Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        "Info",
                      ),
                    ),
                  ],
                ),
                content: Text(e.message.toString()),
              );
            },
          );
        },
        codeSent: (String id, [int? forcesend]) {
          setState(() {
            isLoading = false;
            verificationId = id;
          });
          gotoVerificationScreen();
        },
        codeAutoRetrievalTimeout: (String id) {
          verificationId = id;
          isLoading = false;
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        errorMessageHandler(
          context,
          e.toString(),
        );
      }
    }
  }

  void onContinue() {
    if (_formKey.currentState?.validate() ?? false) {}
  }

  void onGoBack() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onGoBack: onGoBack,
        title: widget.registerArguments.fromScreen == "signup"
            ? "Registration"
            : "Forgot Password",
      ),
      body: Form(
        autovalidateMode:
            isNextBottonPressed ? AutovalidateMode.onUserInteraction : null,
        key: _formKey,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * .15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          bottom: 10,
                          left: MediaQuery.of(context).size.width * .07,
                          right: MediaQuery.of(context).size.width * .07),
                      child: const CustomText(
                        title: "Enter your phone number to get started",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 20,
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
                        left: MediaQuery.of(context).size.width * .07,
                        right: MediaQuery.of(context).size.width * .07),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: const CustomText(
                      title: "Phone Number",
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  PhoneNumberTextField(
                    textInputAction: TextInputAction.next,
                    controller: phoneNumberController,
                    validater: (value) => phoneNumberValidator(value, context),
                    onChange: phoneNumberOnChange,
                    onFieldSubmit: (value) => onContinue(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                      listener: _authListener,
                      builder: (context, state) {
                        return CustomButton(
                          isLoading:
                              isLoading || state is AuthCheckPhoneNumberLoading,
                          loadingText: "Please wait...",
                          onPressed: onContinue,
                          title: "continue",
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _authListener(context, state) {
    if (state is AuthCheckPhoneNumberFaulire) {
      errorMessageHandler(
        context,
        state.failure.errorMessage,
      );
    }
    if (state is AuthCheckPhoneNumberSuccess) {
      print(state.isParentExist);
      print(widget.registerArguments.fromScreen);
      if (state.isParentExist) {
        if (widget.registerArguments.fromScreen == "signup") {
          errorMessageHandler(
            context,
            "User already exist",
          );
        } else {
          ///go to
          setState(() {
            isLoading = true;
          });
          authenticatePhone(context);
        }
      } else {
        if (widget.registerArguments.fromScreen != "signup") {
          errorMessageHandler(
            context,
            "User not exist",
          );
        } else {
          setState(() {
            isLoading = true;
          });
          authenticatePhone(context);
        }

        // gotoVerificationScreen();
      }
    }
  }
}
