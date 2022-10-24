import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/domain/goal/goal.dart';

class GoalRepository {
  static const dbFileName = 'three_days.db';
  static const goalTableName = 'goal';

  Future<Goal> save(Goal goal) async {
    final db = await _getDatabase();
    final goalId = await db.insert(
      goalTableName,
      goal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (kDebugMode) {
      print('GoalRepository.save goal: $goal');
    }
    goal.setId(goalId);
    return goal;
  }

  Future<List<Goal>> findAll() async {
    final db = await _getDatabase();
    return await db
        .query(goalTableName)
        .then((value) => value.map((e) => Goal.fromJson(e)).toList());
  }

  Future<void> deleteAll() async {
    final db = await _getDatabase();
    await db.delete(goalTableName);
  }

  Future<void> deleteById(int goalId) async {
    final db = await _getDatabase();
    await db.delete(
      goalTableName,
      where: 'goalId = ?',
      whereArgs: [goalId],
    );
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbFileName),
    );
  }
}
