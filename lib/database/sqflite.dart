import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note/object/NoteObject.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";


  static Future<Database> _getDB() async {

    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE Note(id INTEGER PRIMARY KEY, nameNote TEXT, contentNote TEXT NOT NULL, "check" INTEGER)'),
        version: _version);
  }

  static Future<int> insertNote(NoteObject note) async {

    final db = await _getDB();
    return await db.insert("Note", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(NoteObject note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  static Future<int> updateNoteCheck(NoteObject note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
       );
  }

  static Future<int> deleteNote(NoteObject note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<NoteObject>?> getAllNotestrue() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps =
        await db.query("Note", orderBy: "nameNote ASC",where:'"check"=true');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => NoteObject.fromJson(maps[index]));
  }
  static Future<List<NoteObject>?> getAllNotesfalse() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps =
        await db.query("Note", orderBy: "nameNote ASC",where:'"check"=false');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => NoteObject.fromJson(maps[index]));
  }
}
