import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/domain/goal/clap/clap.dart';

class ClapRepository {
  static const dbFileName = 'three_days.db';
  static const clapTableName = 'clap';

  Future<List<Clap>> findAll() async {
    final db = await _getDatabase();
    return db.query(
      clapTableName,
    ).then((value) => value.map((e) => Clap.fromJson(e)).toList());
  }

  Future<List<Clap>> findByGoalId(int goalId) async {
    final db = await _getDatabase();
    return db.query(
      clapTableName,
      where: 'goalId = ?',
      whereArgs: [goalId],
    ).then((value) => value.map((e) => Clap.fromJson(e)).toList());
  }

  Future<Clap?> findById(int clapId) async {
    final db = await _getDatabase();
    return db.query(
      clapTableName,
      where: 'clapId = ?',
      whereArgs: [clapId],
    ).then((value) {
      try {
        return value.map((e) => Clap.fromJson(e)).toList().first;
      } on StateError catch (_) {
        return null;
      }
    });
  }

  Future<void> save(Clap clap) async {}

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbFileName),
    );
  }
}
