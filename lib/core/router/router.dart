import 'package:emebet/features/auth/domain/models/auth_use_case.dart';
import 'package:emebet/features/auth/presentaion/pages/change_password.dart';
import 'package:emebet/features/auth/presentaion/pages/login.dart';
import 'package:emebet/features/auth/presentaion/pages/verification.dart';
import 'package:emebet/features/feedback/presentation/pages/delete_account.dart';
import 'package:emebet/features/feedback/presentation/pages/feedback.dart';
import 'package:emebet/features/int/onboarding/presentation/onboarding.dart';
import 'package:emebet/features/notification/presentation/pages/notification.dart';
import 'package:emebet/shared/presentation/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentaion/pages/profile.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      // Ny Times Articles page
      case OnBoardingScreen.routeName:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const OnBoardingScreen(),
        );
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const LoginScreen(),
        );
      // case HomeScreen.routeName:
      //   return CupertinoPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (_) => const HomeScreen(),
      //   );
      case Profile.routeName:
        String name = settings.arguments as String;
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Profile(
            name: name,
          ),
        );
      case ChangePassword.routeName:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const ChangePassword(),
        );
      case FeedBack.routeName:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const FeedBack(),
        );
      case DeleteAccount.routeName:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const DeleteAccount(),
        );
      case Notifications.routeName:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const Notifications(),
        );

      case VerificationScreen.routeName:
        ConfirmOtpArguments confirmOtpArguments =
            settings.arguments as ConfirmOtpArguments;
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => VerificationScreen(
            confirmOtpArguments: confirmOtpArguments,
          ),
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            appBar: CustomAppBar(title: settings.name ?? ""),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
