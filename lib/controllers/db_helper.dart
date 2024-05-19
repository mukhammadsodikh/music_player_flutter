import 'dart:async';
import 'package:music_player_flutter/controllers/song_vm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('songs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE songs (
      id INTEGER PRIMARY KEY,
      title TEXT,
      artist TEXT,
      path TEXT,
      isFavorite INTEGER
    )
    ''');
  }

  Future<int> create(Song song) async {
    final db = await instance.database;
    return await db.insert('songs', song.toMap());
  }

  Future<Song?> readSong(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'songs',
      columns: ['id', 'title', 'artist', 'path', 'isFavorite'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Song.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Song>> readAllSongs() async {
    final db = await instance.database;

    final orderBy = 'title ASC';
    final result = await db.query('songs', orderBy: orderBy);

    return result.map((json) => Song.fromMap(json)).toList();
  }

  Future<int> update(Song song) async {
    final db = await instance.database;

    return db.update(
      'songs',
      song.toMap(),
      where: 'id = ?',
      whereArgs: [song.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'songs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
