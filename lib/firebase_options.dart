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
        return windows;
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
    apiKey: 'AIzaSyAibzebJ1dk4ZYemFOWhGJ4rHy_m4Egzu0',
    appId: '1:225924218843:web:625387b6675a40a5d531fe',
    messagingSenderId: '225924218843',
    projectId: 'quamin-health-module',
    authDomain: 'quamin-health-module.firebaseapp.com',
    storageBucket: 'quamin-health-module.firebasestorage.app',
    measurementId: 'G-2QHWFT0MR4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaauBxWLTXLmCCFJMlFF5srQiK1cZoDW0',
    appId: '1:225924218843:android:5088d4d68e005980d531fe',
    messagingSenderId: '225924218843',
    projectId: 'quamin-health-module',
    storageBucket: 'quamin-health-module.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxmNawym4DUsPD7eCHSJdIXR4f6acfciM',
    appId: '1:225924218843:ios:85c3c05d2b38fd7bd531fe',
    messagingSenderId: '225924218843',
    projectId: 'quamin-health-module',
    storageBucket: 'quamin-health-module.firebasestorage.app',
    iosBundleId: 'com.example.quaminHealthModule',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxmNawym4DUsPD7eCHSJdIXR4f6acfciM',
    appId: '1:225924218843:ios:85c3c05d2b38fd7bd531fe',
    messagingSenderId: '225924218843',
    projectId: 'quamin-health-module',
    storageBucket: 'quamin-health-module.firebasestorage.app',
    iosBundleId: 'com.example.quaminHealthModule',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAibzebJ1dk4ZYemFOWhGJ4rHy_m4Egzu0',
    appId: '1:225924218843:web:7e0b3d37b1205752d531fe',
    messagingSenderId: '225924218843',
    projectId: 'quamin-health-module',
    authDomain: 'quamin-health-module.firebaseapp.com',
    storageBucket: 'quamin-health-module.firebasestorage.app',
    measurementId: 'G-PBNRK8GR5X',
  );

}