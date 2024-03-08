import 'package:flutter/cupertino.dart';
import 'package:music_player_flutter/controllers/song_dao.dart';
import 'package:music_player_flutter/controllers/song_vm.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs => _songs;

  Future<void> fetchSongs() async {
    _songs = await SongDatabase.instance.readAllSongs();
    notifyListeners();
  }

  Future<void> addSong(Song song) async {
    await SongDatabase.instance.create(song);
    fetchSongs();
  }

  Future<void> toggleFavorite(Song song) async {
    final updatedSong = song.copy(isFavorite: !song.isFavorite);
    await SongDatabase.instance.update(updatedSong);
    fetchSongs();
  }

  List<Song> get favoriteSongs {
    return _songs.where((song) => song.isFavorite).toList();
  }
}
