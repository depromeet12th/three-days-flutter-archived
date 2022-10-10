import 'package:flutter/material.dart';
import 'package:three_days/task/task_create_page.dart';
import 'package:three_days/task/task_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color.fromRGBO(0x1A, 0x1F, 27, 1.0),
          ),
        )
      ),
      initialRoute: '/task/list',
      routes: {
        '/task/list': (context) => const TaskListPage(),
        '/task/create': (context) => const TaskCreatePage(),
      },
    );
  }
}
