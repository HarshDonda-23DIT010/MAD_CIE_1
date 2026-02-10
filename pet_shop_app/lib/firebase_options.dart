import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase configuration for the Pet Shop App.
/// 
/// IMPORTANT: Replace these placeholder values with your actual Firebase
/// project configuration. You can get these from the Firebase Console:
/// 1. Go to https://console.firebase.google.com
/// 2. Create a new project or select existing one
/// 3. Add an Android/iOS/Web app
/// 4. Copy the configuration values below
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
        throw UnsupportedError('Linux is not supported');
      default:
        throw UnsupportedError('Unknown platform');
    }
  }

  // ══════════════════════════════════════════════════════════════
  // REPLACE THE VALUES BELOW WITH YOUR FIREBASE PROJECT CONFIG
  // ══════════════════════════════════════════════════════════════

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-pet-shop-project',
    authDomain: 'your-pet-shop-project.firebaseapp.com',
    storageBucket: 'your-pet-shop-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-pet-shop-project',
    storageBucket: 'your-pet-shop-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-pet-shop-project',
    storageBucket: 'your-pet-shop-project.appspot.com',
    iosBundleId: 'com.petshop.petShopApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: '1:000000000000:macos:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-pet-shop-project',
    storageBucket: 'your-pet-shop-project.appspot.com',
    iosBundleId: 'com.petshop.petShopApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'YOUR_WINDOWS_API_KEY',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'your-pet-shop-project',
    authDomain: 'your-pet-shop-project.firebaseapp.com',
    storageBucket: 'your-pet-shop-project.appspot.com',
  );
}
