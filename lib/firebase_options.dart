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
    apiKey: 'AIzaSyDhfbCncuTDFEUYcw8_pBdv14tAdzLmOTw',
    appId: '1:316357067199:web:336b8af45b84e2cb22610a',
    messagingSenderId: '316357067199',
    projectId: 'task-app-db136',
    authDomain: 'task-app-db136.firebaseapp.com',
    storageBucket: 'task-app-db136.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8u2NReU4eD5Ce75cexZ5BZ2SXOcuM-k8',
    appId: '1:316357067199:android:cb6cd6ca38a3e5e822610a',
    messagingSenderId: '316357067199',
    projectId: 'task-app-db136',
    storageBucket: 'task-app-db136.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALnvSbFp0swDME8VR3XrYILMJvjRSx3Rg',
    appId: '1:316357067199:ios:92106f301a89878422610a',
    messagingSenderId: '316357067199',
    projectId: 'task-app-db136',
    storageBucket: 'task-app-db136.appspot.com',
    iosBundleId: 'com.example.tasksapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALnvSbFp0swDME8VR3XrYILMJvjRSx3Rg',
    appId: '1:316357067199:ios:4dc6d18ae473bd3e22610a',
    messagingSenderId: '316357067199',
    projectId: 'task-app-db136',
    storageBucket: 'task-app-db136.appspot.com',
    iosBundleId: 'com.example.tasksapp.RunnerTests',
  );
}
