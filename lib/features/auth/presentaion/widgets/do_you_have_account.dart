import 'package:emebet/core/styles/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DoYouHaveAccount extends StatelessWidget {
  const DoYouHaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              style: TextStyle(
                  color: Color(0xff242121),
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
              text: "Don't have an account yet? ",
            ),
            TextSpan(
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              text: "Sign up",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigator.pushNamed(context, SignupScreen.routeName,
                  //     arguments: RegisterArguments(fromScreen: 'signup')

                      // {"from": "signup"},
                      // );
                },
            ),
          ],
        ),
      ),
    );
  }
}
