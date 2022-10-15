import 'package:flutter/material.dart';

class GoalEditPage extends StatefulWidget {
  const GoalEditPage({super.key});

  @override
  State<StatefulWidget> createState() => _GoalEditPageState();
}

class _GoalEditPageState extends State<GoalEditPage> {

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Goal Edit Page'),
        ),
      ),
    );
  }
}
