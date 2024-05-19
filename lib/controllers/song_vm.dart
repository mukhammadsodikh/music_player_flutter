import 'package:get/get_rx/src/rx_types/rx_types.dart';
class Song {
  final int id;
  final String title;
  final String artist;
  final String path;
  final RxBool isFavorite;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    bool isFavorite = false,
  }) : isFavorite = RxBool(isFavorite);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'path': path,
      'isFavorite': isFavorite.value ? 1 : 0,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      path: map['path'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
