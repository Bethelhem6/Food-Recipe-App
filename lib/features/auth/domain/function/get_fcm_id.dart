import 'package:firebase_messaging/firebase_messaging.dart';

String firebaseAppToken = '';
Future<String> getFirebaseMessagingToken() async {
  try {
    firebaseAppToken = await FirebaseMessaging.instance.getToken() ?? "";
    return firebaseAppToken;
  } catch (e) {
    return "";
  }
}
