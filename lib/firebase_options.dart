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
    apiKey: 'AIzaSyAgEt8VlThsXtIM5r4Ym1AGkS2X0ax65bA',
    appId: '1:772669751616:web:ad0b3443eefa4ea0447aa5',
    messagingSenderId: '772669751616',
    projectId: 'flutter-auth-ff314',
    authDomain: 'flutter-auth-ff314.firebaseapp.com',
    storageBucket: 'flutter-auth-ff314.appspot.com',
    // clientid: '772669751616-j6jb3qn73j14mpuoejk6d61lsrckqj8s.apps.googleusercontent.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlyd3E6vdUrL__6yQCKXnsBUlMxed6_3A',
    appId: '1:772669751616:android:69511ccc2290bae2447aa5',
    messagingSenderId: '772669751616',
    projectId: 'flutter-auth-ff314',
    storageBucket: 'flutter-auth-ff314.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARIToiYp75AmX1mjJMw9Thju3JcVjBsSM',
    appId: '1:772669751616:ios:e21d270402aed1e6447aa5',
    messagingSenderId: '772669751616',
    projectId: 'flutter-auth-ff314',
    storageBucket: 'flutter-auth-ff314.appspot.com',
    androidClientId: '772669751616-6esugfjj9g1749of3idc9mrdstr3mm4i.apps.googleusercontent.com',
    iosClientId: '772669751616-h1ftpm2f7ijl4j5j0q4it323kb9r7cq4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterAuthentication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARIToiYp75AmX1mjJMw9Thju3JcVjBsSM',
    appId: '1:772669751616:ios:e21d270402aed1e6447aa5',
    messagingSenderId: '772669751616',
    projectId: 'flutter-auth-ff314',
    storageBucket: 'flutter-auth-ff314.appspot.com',
    androidClientId: '772669751616-6esugfjj9g1749of3idc9mrdstr3mm4i.apps.googleusercontent.com',
    iosClientId: '772669751616-h1ftpm2f7ijl4j5j0q4it323kb9r7cq4.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterAuthentication',
  );
}
