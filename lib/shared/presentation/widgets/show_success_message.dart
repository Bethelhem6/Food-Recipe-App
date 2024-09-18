import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class DisplayMessage {
  static OverlaySupportEntry success(String message) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       message,
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //     backgroundColor: Colors.green,
    //     duration: const Duration(seconds: 2),
    //   ),
    // );

    return showSimpleNotification(
      Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 80,
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Text(
                message,
                softWrap: true,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
      background: Colors.transparent,
      duration: const Duration(seconds: 4),
    );
  }

  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.replaceAll("Exception:", ''),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.replaceAll("Exception:", ''),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
