import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/goal/goal.dart';

class GoalRepository {
  Future<Goal> save(Goal goal) async {
    final db = await _getDatabase();
    await db.insert(
      'goal',
      goal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return goal;
  }

  Future<List<Goal>> findAll() async {
    final db = await _getDatabase();
    return await db
        .query('goal')
        .then((value) => value.map((e) => Goal.fromJson(e)).toList());
  }

  Future<void> deleteAll() async {
    final db = await _getDatabase();
    await db.delete('goal');
  }

  Future<void> deleteById(int goalId) async {
    final db = await _getDatabase();
    await db.delete('goal', where: 'goalId = ?', whereArgs: [goalId]);
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'three_days.db'),
    );
  }
}
