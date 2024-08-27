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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbMYAxSdboaUTLVItIYX9zmFhfQuihSOU',
    appId: '1:479975444628:web:6fa50caeaafba94fd1a481',
    messagingSenderId: '479975444628',
    projectId: 'my-study-project-f6e98',
    authDomain: 'my-study-project-f6e98.firebaseapp.com',
    storageBucket: 'my-study-project-f6e98.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuBzRRiNH_UqbQzavUV7ZrRV2sly8b4ho',
    appId: '1:479975444628:android:077e134e7b4d6b2bd1a481',
    messagingSenderId: '479975444628',
    projectId: 'my-study-project-f6e98',
    storageBucket: 'my-study-project-f6e98.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4PgsTHaFQx1FJESxu-8ooTib13rxcuFI',
    appId: '1:479975444628:ios:1b84e7848cb7f491d1a481',
    messagingSenderId: '479975444628',
    projectId: 'my-study-project-f6e98',
    storageBucket: 'my-study-project-f6e98.appspot.com',
    iosBundleId: 'com.example.pets',
  );
}
