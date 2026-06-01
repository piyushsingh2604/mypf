import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfOX4Caw-Jj8a3Pp8GrlGKxyitZYCf8uc',
    appId: '1:1002501930576:web:9aeece19f7b9226f1ddb55',
    messagingSenderId: '1002501930576',
    projectId: 'piyushpf-8e95b',
    authDomain: 'piyushpf-8e95b.firebaseapp.com',
    storageBucket: 'piyushpf-8e95b.firebasestorage.app',
    measurementId: 'G-TY6X0KR2G9',
  );
}