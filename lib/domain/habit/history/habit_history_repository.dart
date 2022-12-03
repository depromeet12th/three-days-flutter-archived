import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/domain/habit/history/habit_history.dart';

class HabitHistoryRepository {
  static const dbFileName = 'three_days.db';
  static const goalHistoryTableName = 'goal_history';

  Future<List<HabitHistory>> findAll() async {
    final db = await _getDatabase();
    return db
        .query(goalHistoryTableName)
        .then((value) => value.map((e) => HabitHistory.fromJson(e)).toList());
  }

  Future<List<HabitHistory>> findByHabitId(int habitId) async {
    final db = await _getDatabase();
    return db.query(
      goalHistoryTableName,
      where: 'goalId = ?',
      whereArgs: [habitId],
    ).then((value) => value.map((e) => HabitHistory.fromJson(e)).toList());
  }

  Future<HabitHistory> save(HabitHistory habitHistory) async {
    final db = await _getDatabase();
    final habitHistoryId = await db.insert(
      goalHistoryTableName,
      habitHistory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    habitHistory.setId(habitHistoryId);
    if (kDebugMode) {
      print('HabitHistoryRepository.save $habitHistory');
    }
    return habitHistory;
  }

  Future<void> delete(int habitHistoryId) async {
    final db = await _getDatabase();
    await db.delete(
      goalHistoryTableName,
      where: 'goalHistoryId = ?',
      whereArgs: [habitHistoryId],
    );
  }

  Future<void> deleteByHabitId(int habitId) async {
    final db = await _getDatabase();
    await db.delete(
      goalHistoryTableName,
      where: 'goalId = ?',
      whereArgs: [habitId],
    );
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbFileName),
    );
  }
}
