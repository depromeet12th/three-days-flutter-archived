import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/domain/habit/habit.dart';

class HabitRepository {
  static const dbFileName = 'three_days.db';
  // FIXME: db 는 마이그레이션하는 것보다, 일단 유지하고 나중에 api 붙일 때 지워버릴 예정
  static const goalTableName = 'goal';

  final habits = [
    Habit(habitId: 1, title: '아침 챙겨먹기'),
    Habit(habitId: 2, title: '점심 직후 종합 비타민'),
    Habit(habitId: 3, title: '매주 토요일 아침 런닝'),
    Habit(habitId: 4, title: '평일 아침 아티클 읽자!'),
    Habit(habitId: 5, title: '우주인과 교신하기'),
    Habit(habitId: 6, title: '아침 챙겨먹기'),
    Habit(habitId: 7, title: '점심 직후 종합 비타민'),
    Habit(habitId: 8, title: '매주 토요일 아침 런닝'),
    Habit(habitId: 9, title: '평일 아침 아티클 읽자!'),
    Habit(habitId: 10, title: '우주인과 교신하기'),
    Habit(habitId: 11, title: '아침 챙겨먹기'),
    Habit(habitId: 12, title: '점심 직후 종합 비타민'),
    Habit(habitId: 13, title: '매주 토요일 아침 런닝'),
    Habit(habitId: 14, title: '평일 아침 아티클 읽자!'),
    Habit(habitId: 15, title: '우주인과 교신하기'),
  ];

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
    return habits;
    final db = await _getDatabase();
    return await db
        .query(goalTableName)
        .then((value) => value.map((e) => Habit.fromJson(e)).toList());
  }

  Future<Habit> findById(int habitId) async {
    return habits.firstWhere((e) => e.habitId == habitId);
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
