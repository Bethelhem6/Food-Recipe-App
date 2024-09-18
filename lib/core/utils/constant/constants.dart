import 'dart:io';

import 'package:flutter/material.dart';

class Constants {
  static String googleApikey = Platform.isIOS
      ? "AIzaSyAV8ljrYLYeaRH5XlnxVIJqDu5Y1EuLOJA"
      : "AIzaSyDxXUL8bFNWPYQdnJVY16tNZuo00usZnwc";

  static BuildContext? globalContext;
}
