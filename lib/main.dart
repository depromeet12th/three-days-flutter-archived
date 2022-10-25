import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
        iosClientId:
            '526416542267-vi5e0m24ogr6n5dmu96oos99k75fu6hn.apps.googleusercontent.com',
        iosBundleId: 'com.example.threeDays',
      ),
    );
  }

  openDatabase(
    join(await getDatabasesPath(), 'three_days.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) async {
      if (kDebugMode) {
        print('database.onCreate.db: $db');
        print('database.onCreate.version: $version');
      }
      // Run the CREATE TABLE statement on the database.
      await db.execute(
          'CREATE TABLE goal(goalId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT)');
      await db.execute(
          'CREATE TABLE goal_history(goalHistoryId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, goalId INTEGER, checkedAt TEXT)');
      await db.execute(
          'CREATE TABLE clap(clapId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, goalId INTEGER, goalHistoryId INTEGER, createdAt TEXT)');
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 6,
  );

  runApp(const MyApp());
}
