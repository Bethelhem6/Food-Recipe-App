// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaabAcH6VTnrMPDM7sKgpswefumUR1SKg',
    appId: '1:121035670311:android:aafa32997f466164bd5f02',
    messagingSenderId: '121035670311',
    projectId: 'vintage-team-test-project',
    databaseURL: 'https://vintage-team-test-project-default-rtdb.firebaseio.com',
    storageBucket: 'vintage-team-test-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIfk0FefAj8wY9piaOXisf14nvE3el6Q4',
    appId: '1:121035670311:ios:07b7d004f423dafebd5f02',
    messagingSenderId: '121035670311',
    projectId: 'vintage-team-test-project',
    databaseURL: 'https://vintage-team-test-project-default-rtdb.firebaseio.com',
    storageBucket: 'vintage-team-test-project.appspot.com',
    androidClientId: '121035670311-07mn9jj13d7i2m0ja2e40a083qsqcncv.apps.googleusercontent.com',
    iosBundleId: 'com.vintage.mvvm',
  );
}
