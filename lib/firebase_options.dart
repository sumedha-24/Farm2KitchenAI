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
    apiKey: 'AIzaSyBELWuVgRx86rPa0cEUQLb1_LXBMh5CZPQ',
    appId: '1:665266063910:web:115d231d0e0e3d037eb4e7',
    messagingSenderId: '665266063910',
    projectId: 'farm2kitchen-40f3e',
    authDomain: 'farm2kitchen-40f3e.firebaseapp.com',
    storageBucket: 'farm2kitchen-40f3e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgrfshle2xFknRqDQWHWLDXqB5sL-ufFI',
    appId: '1:665266063910:android:2860e492e9209cb87eb4e7',
    messagingSenderId: '665266063910',
    projectId: 'farm2kitchen-40f3e',
    storageBucket: 'farm2kitchen-40f3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRIX4KeI2Osr8xvg55io6uKbr9EGtSCvE',
    appId: '1:665266063910:ios:6bfe4a34846716297eb4e7',
    messagingSenderId: '665266063910',
    projectId: 'farm2kitchen-40f3e',
    storageBucket: 'farm2kitchen-40f3e.appspot.com',
    iosClientId: '665266063910-833drfjbdnh81dvt07mem2dfr39676e5.apps.googleusercontent.com',
    iosBundleId: 'com.example.farm2kitchen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRIX4KeI2Osr8xvg55io6uKbr9EGtSCvE',
    appId: '1:665266063910:ios:6bfe4a34846716297eb4e7',
    messagingSenderId: '665266063910',
    projectId: 'farm2kitchen-40f3e',
    storageBucket: 'farm2kitchen-40f3e.appspot.com',
    iosClientId: '665266063910-833drfjbdnh81dvt07mem2dfr39676e5.apps.googleusercontent.com',
    iosBundleId: 'com.example.farm2kitchen',
  );
}
