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
    apiKey: 'AIzaSyDO5k-ccF2XlawwBiM1bUA08HPnMLwYJHY',
    appId: '1:169066384439:web:2fd4b568158e5c8ef343b2',
    messagingSenderId: '169066384439',
    projectId: 'ali-mynotes-app',
    authDomain: 'ali-mynotes-app.firebaseapp.com',
    storageBucket: 'ali-mynotes-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP8O0E6alCHGhZywaJvI4wOYu12PgwN0c',
    appId: '1:169066384439:android:f4c217e863f15dbff343b2',
    messagingSenderId: '169066384439',
    projectId: 'ali-mynotes-app',
    storageBucket: 'ali-mynotes-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDd_eIlVA9xiHK0iAx5f5wvGb2kyxINyOE',
    appId: '1:169066384439:ios:7695fb6c845c9f7cf343b2',
    messagingSenderId: '169066384439',
    projectId: 'ali-mynotes-app',
    storageBucket: 'ali-mynotes-app.appspot.com',
    iosClientId: '169066384439-4qrqoh9ovu4j07b04nbg29fqr4ui1207.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterNotesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDd_eIlVA9xiHK0iAx5f5wvGb2kyxINyOE',
    appId: '1:169066384439:ios:7695fb6c845c9f7cf343b2',
    messagingSenderId: '169066384439',
    projectId: 'ali-mynotes-app',
    storageBucket: 'ali-mynotes-app.appspot.com',
    iosClientId: '169066384439-4qrqoh9ovu4j07b04nbg29fqr4ui1207.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterNotesApp',
  );
}