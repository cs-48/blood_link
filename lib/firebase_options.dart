// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7t4MA2pO4QuvbisdmVPTh0_VN0hGZ1FY',
    appId: '1:827550457264:web:fb53aebc513c94d1fb8a75',
    messagingSenderId: '827550457264',
    projectId: 'bloodlink-71833',
    authDomain: 'bloodlink-71833.firebaseapp.com',
    storageBucket: 'bloodlink-71833.appspot.com',
    measurementId: 'G-NHV23DMSM6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXlAS8Cd98EnJgPOVsEXQ1zN2xnDj5dTE',
    appId: '1:827550457264:android:88ae2eb16e11d219fb8a75',
    messagingSenderId: '827550457264',
    projectId: 'bloodlink-71833',
    storageBucket: 'bloodlink-71833.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcpyG97aBulk5afTm6SFvlLiR1o-bZq-0',
    appId: '1:827550457264:ios:f5db26d0b5898c9ffb8a75',
    messagingSenderId: '827550457264',
    projectId: 'bloodlink-71833',
    storageBucket: 'bloodlink-71833.appspot.com',
    iosBundleId: 'com.example.bloodLink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcpyG97aBulk5afTm6SFvlLiR1o-bZq-0',
    appId: '1:827550457264:ios:72e37198ce265220fb8a75',
    messagingSenderId: '827550457264',
    projectId: 'bloodlink-71833',
    storageBucket: 'bloodlink-71833.appspot.com',
    iosBundleId: 'com.example.bloodLink.RunnerTests',
  );
}
