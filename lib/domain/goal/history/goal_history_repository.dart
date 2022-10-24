import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/domain/goal/history/goal_history.dart';

class GoalHistoryRepository {
  static const dbFileName = 'three_days.db';
  static const goalHistoryTableName = 'goal_history';

  Future<List<GoalHistory>> findAll() async {
    final db = await _getDatabase();
    return db
        .query(goalHistoryTableName)
        .then((value) => value.map((e) => GoalHistory.fromJson(e)).toList());
  }

  Future<List<GoalHistory>> findByGoalId(int goalId) async {
    final db = await _getDatabase();
    return db.query(
      goalHistoryTableName,
      where: 'goalId = ?',
      whereArgs: [goalId],
    ).then((value) => value.map((e) => GoalHistory.fromJson(e)).toList());
  }

  Future<GoalHistory> save(GoalHistory goalHistory) async {
    final db = await _getDatabase();
    final goalHistoryId = await db.insert(
      goalHistoryTableName,
      goalHistory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    goalHistory.setId(goalHistoryId);
    return goalHistory;
  }

  Future<void> delete(int goalHistoryId) async {
    final db = await _getDatabase();
    await db.delete(
      goalHistoryTableName,
      where: 'goalHistoryId = ?',
      whereArgs: [goalHistoryId],
    );
  }

  Future<void> deleteByGoalId(int goalId) async {
    final db = await _getDatabase();
    await db.delete(
      goalHistoryTableName,
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
