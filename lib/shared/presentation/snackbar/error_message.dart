import 'package:flutter/material.dart';

Future errorMessageHandler(BuildContext context, String errorMessage) async {
  if (errorMessage.contains("Unauthorized")) {
    // AuthRepository(httpClient: http.Client()).directLogout().then((value) {
    //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     RoutesScreen.login,
    //     (route) => false,
    //   );
    // }).catchError((err) {
    //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     RoutesScreen.login,
    //     (route) => false,
    //   );
    // });
  } else if (errorMessage == "timeout") {
    // timeout(fun ?? null, context);
  } else if (errorMessage.contains("html")) {
    showErrorSnackBar(
      context,
      "Server is not working",
    );
  } else {
    showErrorSnackBar(
      context,
      errorMessage,
    );
  }
}

void showErrorSnackBar(BuildContext ctx, String message) {
  var snackBar = SnackBar(
      dismissDirection: DismissDirection.horizontal,
      content: Row(
        children: [
          const Icon(Icons.info, color: Colors.white),
          const SizedBox(
            width: 10,
          ),
          Flexible(child: Text(message)),
        ],
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red);
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}
