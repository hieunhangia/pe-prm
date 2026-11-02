import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/work_model.dart';

part 'work_repository.g.dart';

@Riverpod(keepAlive: true)
WorkRepository workRepository(Ref ref) {
  return WorkRepository();
}

class WorkRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE works (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    isCompleted INTEGER NOT NULL
  )
''');
    await db.insert('works', {
      'title': 'Làm bài tập Flutter',
      'description': 'Hoàn thành trước thứ Sáu',
      'isCompleted': 0,
    });
    await db.insert('works', {
      'title': 'Ôn tập Riverpod',
      'description': 'Xem lại bài giảng MVVM',
      'isCompleted': 0,
    });
  }

  Future<List<WorkModel>> getAll() async {
    final db = await database;
    final result = await db.query('works');
    return result.map((json) => WorkModel.fromMap(json)).toList();
  }

  Future<int> update(WorkModel item) async {
    final db = await database;
    return await db.update(
      'works',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}
