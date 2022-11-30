import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/my_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    if (kDebugMode) {
      print('User granted permission');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    if (kDebugMode) {
      print('User granted provisional permission');
    }
  } else {
    if (kDebugMode) {
      print('User declined or has not accepted permission');
    }
  }

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcmToken: $fcmToken');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

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
