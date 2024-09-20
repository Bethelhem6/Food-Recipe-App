import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:mvvm/core/utils/constant/app_assets.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:root_tester/root_tester.dart';

import '../../../core/local_storage/local_storage.dart';
import '../../../core/local_storage/tokens.dart';
import '../../../core/styles/app_colors.dart';
import '../../auth/presentaion/pages/login.dart';
import '../onboarding/presentation/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool isConnected = false;
  bool isTrying = true;
  AnimationController? _animationController;
  Animation<Offset>? _animation;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryGreen,
      statusBarIconBrightness: Brightness.light,
    ));
    isSecureDevice();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    const startPosition = Offset(0, 100);
    const endPosition = Offset(0, 0);
    final curvedAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOut,
    );
    _animation = Tween<Offset>(begin: startPosition, end: endPosition)
        .animate(curvedAnimation);

    _animationController!.forward();
  }

  Future isSecureDevice() async {
    bool isDeviceRooted = await RootTester.isDeviceRooted;
    final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
    if (isDeviceRooted || isRealDevice == false) {
      startTimer();
      // BlocProvider.of<GlobalConfigBloc>(context).add(GlobalConfigGet());
      // showDeviceIsNotSafeDialog();
    } else {
      startTimer();
      // BlocProvider.of<GlobalConfigBloc>(context).add(GlobalConfigGet());
    }
  }

  showDeviceIsNotSafeDialog() {
    PanaraInfoDialog.show(context,
        message:
            'Your device is rooted or running on an unsafe environment. For security reasons, this app cannot run on rooted devices or simulators. Please use a secure, non-rooted device to access this app.',
        buttonText: 'Close', onTapDismiss: () {
      if (Platform.isIOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
    }, panaraDialogType: PanaraDialogType.error);
  }

  showNoInternetSnackbar() {
    SnackBar snack = SnackBar(
        duration: const Duration(days: 1),
        content: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.wifi_off,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              flex: 4,
              child: Text(
                "You are offline!",
                softWrap: true,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isTrying = false;
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  isSecureDevice();
                },
                child: const Text("Try again"),
              ),
            ),
          ],
        ));
    setState(() {
      isTrying = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  gotoOnboarding() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      OnBoardingScreen.routeName,
      (route) => false,
    );
  }

  gotoLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => false,
    );
  }

  gotoHome() {
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   // AddKidScreen.routeName,
    //   HomeScreen.routeName,
    //   (route) => false,
    // );
  }

  void startTimer() {
    Timer(const Duration(seconds: 2), () async {
      bool? isFirstTimeOpeningApp = await LocalStorage.isFirstTimeOpeningApp();
      Tokens? tokens = await LocalStorage.getTokens();
      if (isFirstTimeOpeningApp == null) {
        gotoOnboarding();
      } else if (tokens.accessToken != null) {
        gotoHome();
        // gotoLogin();
      } else {
        gotoLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              return Transform.translate(
                offset: _animation!.value,
                child: Opacity(
                  opacity: _animationController!.value,
                  child: Container(
                    child: Image.asset(AppAssets.logo),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
