import 'dart:async';
 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/features/auth/presentaion/pages/forget_password.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../domain/models/auth_use_case.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = "VerificationScreen";
  final ConfirmOtpArguments confirmOtpArguments;
  const VerificationScreen({super.key, required this.confirmOtpArguments});
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<String> _otpDigits = List.generate(6, (_) => '');
  int _animatedIndex = -1;
  int selectedIndex = -1;
  int seconds = 60;
  FirebaseAuth auth = FirebaseAuth.instance;

  String id = '';
  bool isLoading = false;
  Future authenticatePhone(BuildContext ctx) async {
    try {
      verificationComplete(AuthCredential credential) async {}
      await auth.verifyPhoneNumber(
        phoneNumber: widget.confirmOtpArguments.phoneNumber,
        timeout: const Duration(seconds: 100),
        verificationCompleted: verificationComplete,
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
            context: ctx,
            builder: (ctx) {
              return AlertDialog(
                title: Row(
                  children: [
                    const Icon(Icons.info),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        e.message ?? "",
                      ),
                    ),
                  ],
                ),
                content: Text(e.message.toString()),
              );
            },
          );
        },
        codeSent: (String verificationId, [int? forcesend]) {
          setState(() {
            id = verificationId;
            seconds = 100;
          });
          startCountdown();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          id = verificationId;
        },
      );
    } catch (e) {
      if (mounted) {
        errorMessageHandler(
          context,
          e.toString(),
        );
      }
    }
  }

  Future verifyFirebaseOTP(BuildContext ctx, String otp) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        smsCode: otp.trim(),
        verificationId:
            widget.confirmOtpArguments.recievedverificationId.toString().trim(),
      );
      await auth.signInWithCredential(credential).then((value) {
        if (value.user != null) {
          isLoading = false;
          if (widget.confirmOtpArguments.isfromSignup) {
            cancelTimer();
            // RegistrationParam registrationParam = RegistrationParam(
            //     phoneNumber: widget.confirmOtpArguments.phoneNumber);
            // Navigator.popAndPushNamed(
            //   ctx,
            //   RegisterationScreen.routeName,
            //   arguments: registrationParam,
            // );
          }
          if (!widget.confirmOtpArguments.isfromSignup) {
            cancelTimer();
            Navigator.popAndPushNamed(
              ctx,
              ForgetPasswordScreen.routeName,
              arguments: widget.confirmOtpArguments.phoneNumber,
            );
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  // void submitConfirmOTP(BuildContext ctx, String otpCode) async {
  //   await verifyOTP(ctx, otpCode);
  // }

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void _addNumberToOtp(String number) {
    if (_otpDigits.any((digit) => digit.isEmpty)) {
      setState(() {
        int emptyIndex = _otpDigits.indexWhere((digit) => digit.isEmpty);
        _otpDigits[emptyIndex] = number;
        if (number == "0") {
          selectedIndex = 0;
        } else {
          _animatedIndex = int.parse(number) - 1;
        }
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _animatedIndex = -1;
          selectedIndex = -1;
        });
      });
    }
  }

  void _removeLastNumber() {
    setState(() {
      int lastIndex = _otpDigits.lastIndexWhere((digit) => digit.isNotEmpty);
      if (lastIndex >= 0) {
        _otpDigits[lastIndex] = '';
        selectedIndex = 1;
      }
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        selectedIndex = -1;
      });
    });
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  cancelTimer() {
    _timer?.cancel();
  }

  void _clearPassword() {
    setState(() {
      _otpDigits = List.generate(6, (_) => '');
      selectedIndex = -1;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        selectedIndex = -1;
      });
    });
  }

  void verifyOtp() {
    setState(() {
      isLoading = true;
    });
    cancelTimer();
    verifyFirebaseOTP(context, _otpDigits.join(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Verification",
        ) as PreferredSizeWidget,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              if (seconds != 0)
                Text(
                  "00:$seconds",
                  style: const TextStyle(
                      fontSize: 44, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16.0),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .4,
                child: const Text(
                  "Type the verification code we have sent you",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 50.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _otpDigits.length; i++)
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: _otpDigits[i] == ""
                                    ? Colors.white
                                    : AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                border: _otpDigits[i] == ""
                                    ? Border.all(
                                        color: AppColors.primaryColor, width: 2)
                                    : null),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: Text(
                                _otpDigits[i] == "" ? "-" : _otpDigits[i],
                                style: TextStyle(
                                  color: _otpDigits[i] == ""
                                      ? Colors.grey
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 0.0,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 16.0, 16.0, 0.0),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification
                              .disallowIndicator(); // Disable the wave effect
                          return true;
                        },
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            padding: EdgeInsets.zero,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 2,
                            children: List.generate(
                              9,
                              (index) => GestureDetector(
                                onTap: () {
                                  _addNumberToOtp((index + 1).toString());
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: _animatedIndex == index
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.fromLTRB(4.0, 0, 16.0, 16.0),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          padding: EdgeInsets.zero,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 2,
                          children: [
                            GestureDetector(
                              onTap: _removeLastNumber,
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: selectedIndex == 1
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.backspace,
                                    color: Colors.black,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () => _addNumberToOtp('0'),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: selectedIndex == 0
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _clearPassword,
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: selectedIndex == 3
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                  isLoading: isLoading,
                  loadingText: "Loading",
                  onPressed: _otpDigits[5] == "" || isLoading
                      ? null
                      : () => verifyOtp(),
                  title: "Continue"),
              TextButton(
                  onPressed: seconds != 0 || isLoading
                      ? null
                      : () {
                          _clearPassword();
                          authenticatePhone(context);
                        },
                  child: const Text(
                    "Send Again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ));
  }
}
