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
    apiKey: 'AIzaSyAuPFRXEKuyxhX-54z9rzt_JuIoGj12WQU',
    appId: '1:88600842697:web:5b72ba5be05e25f88fd818',
    messagingSenderId: '88600842697',
    projectId: 'app-note-group7',
    authDomain: 'app-note-group7.firebaseapp.com',
    storageBucket: 'app-note-group7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS491NqP4HQfx2s0yRZcT8nkiB0h7n9jA',
    appId: '1:88600842697:android:979c72ec3274390f8fd818',
    messagingSenderId: '88600842697',
    projectId: 'app-note-group7',
    storageBucket: 'app-note-group7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBK7LRBPujT2-2EcdDEJsV15WkSGX_vMuk',
    appId: '1:88600842697:ios:6025fec21e849f678fd818',
    messagingSenderId: '88600842697',
    projectId: 'app-note-group7',
    storageBucket: 'app-note-group7.appspot.com',
    androidClientId: '88600842697-28u83mjcpnt2jtkfre6p8g6f57o2ant7.apps.googleusercontent.com',
    iosClientId: '88600842697-t9oqmq39sv3d4vhmpm5kgqd06ah6efi9.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBK7LRBPujT2-2EcdDEJsV15WkSGX_vMuk',
    appId: '1:88600842697:ios:da54e311290f7a928fd818',
    messagingSenderId: '88600842697',
    projectId: 'app-note-group7',
    storageBucket: 'app-note-group7.appspot.com',
    androidClientId: '88600842697-28u83mjcpnt2jtkfre6p8g6f57o2ant7.apps.googleusercontent.com',
    iosClientId: '88600842697-66s7q6tmiglt8g6676fsms289rd6j57j.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteApp.RunnerTests',
  );
}
