import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:three_days/goal/clap/clap.dart';

class ClapRepository {
  static const dbFileName = 'three_days.db';
  static const clapTableName = 'clap';

  Future<List<Clap>> findByGoalId(int goalId) async {
    final db = await _getDatabase();
    return db.query(
      clapTableName,
      where: 'goalId = ?',
      whereArgs: [goalId],
    ).then((value) => value.map((e) => Clap.fromJson(e)).toList());
  }

  Future<void> save(Clap clap) async {}

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), dbFileName),
    );
  }
}
