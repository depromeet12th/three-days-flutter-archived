import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:three_days/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    var firebaseApiKey = dotenv.get('FIREBASE_API_KEY');
    if (kDebugMode) {
      print(firebaseApiKey);
    }
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: firebaseApiKey,
        appId: '1:526416542267:ios:638558ba14a415bd183a1e',
        messagingSenderId: '526416542267',
        projectId: 'three-days-bd5f3',
        storageBucket: 'three-days-bd5f3.appspot.com',
        iosClientId: '526416542267-vi5e0m24ogr6n5dmu96oos99k75fu6hn.apps.googleusercontent.com',
        iosBundleId: 'com.example.threeDays',
      ),
    );
  }

  runApp(const MyApp());
}
