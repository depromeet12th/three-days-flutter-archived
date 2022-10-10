import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:three_days/task/task.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color.fromRGBO(0xFF, 0xFF, 0xFF, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: const [
                Task(
                  title: '이불 정리하기',
                  days: 1,
                ),
                Task(
                  title: '일어나자마자 물 마시기',
                  days: 3,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/task/create');
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(0x6E, 0x75, 0x7B, 1.0),
          ),
        ),
      ),
    );
  }
}
