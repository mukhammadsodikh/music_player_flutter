import 'package:music_player_flutter/controllers/song_vm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SongDatabase {
  static final SongDatabase instance = SongDatabase._init();
  static Database? _database;

  SongDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('songs.db');
    return _database!;
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
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE songs ( 
      id $idType, 
      title $textType,
      artist $textType,
      path $textType
    )
    ''');
  }

  Future<Song> create(Song song) async {
    final db = await instance.database;
    final id = await db.insert('songs', song.toMap());
    return song.copy(id: id);
  }


  Future<List<Song>> readAllSongs() async {
    final db = await instance.database;

    final orderBy = 'title ASC';
    final result = await db.query('songs', orderBy: orderBy);

    return result.map((json) => Song.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
