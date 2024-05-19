import 'package:flutter/material.dart';
import 'package:music_player_flutter/controllers/song_vm.dart';
import 'db_helper.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];
  List<Song> get songs => _songs;

  Future<void> fetchSongs() async {
    _songs = await DatabaseHelper.instance.readAllSongs();
    notifyListeners();
  }

  Future<void> fetchFavoriteSongs() async {
    _songs = await DatabaseHelper.instance.readAllSongs();
    _songs = _songs.where((song) => song.isFavorite.value).toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(Song song) async {
    song.isFavorite.value = !song.isFavorite.value;
    await DatabaseHelper.instance.update(song);
    notifyListeners();
  }

  Future<void> addSong(Song song) async {
    await DatabaseHelper.instance.create(song);
    fetchSongs();
  }

  Future<void> deleteSong(int id) async {
    await DatabaseHelper.instance.delete(id);
    fetchSongs();
  }
}
