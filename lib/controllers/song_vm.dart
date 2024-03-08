class Song {
  final int? id;
  final String title;
  final String artist;
  final String path;
  final bool isFavorite;

  Song({
    this.id,
    required this.title,
    required this.artist,
    required this.path,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'path': path,
      'isFavorite': isFavorite ? 1 : 0,
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

  Song copy({
    int? id,
    String? title,
    String? artist,
    String? path,
    bool? isFavorite,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
