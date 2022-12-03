import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/domain/habit/habit.dart';

class HabitRepository {
  static const dbFileName = 'three_days.db';
  // FIXME: db 는 마이그레이션하는 것보다, 일단 유지하고 나중에 api 붙일 때 지워버릴 예정
  static const goalTableName = 'goal';

  Future<Habit> save(Habit habit) async {
    final db = await _getDatabase();
    final habitId = await db.insert(
      goalTableName,
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    habit.setId(habitId);
    if (kDebugMode) {
      print('HabitRepository.save $habit');
    }
    return habit;
  }

  Future<List<Habit>> findAll() async {
    final db = await _getDatabase();
    return await db
        .query(goalTableName)
        .then((value) => value.map((e) => Habit.fromJson(e)).toList());
  }

  Future<void> deleteAll() async {
    final db = await _getDatabase();
    await db.delete(goalTableName);
  }

  Future<void> deleteById(int habitId) async {
    final db = await _getDatabase();
    await db.delete(
      goalTableName,
      where: 'habitId = ?',
      whereArgs: [habitId],
    );
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbFileName),
    );
  }
}
