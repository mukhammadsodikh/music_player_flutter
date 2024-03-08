import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/song_provider.dart';

class FavoriteSongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Songs'),
      ),
      body: ListView.builder(
        itemCount: songProvider.favoriteSongs.length,
        itemBuilder: (context, index) {
          final song = songProvider.favoriteSongs[index];
          return ListTile(
            title: Text(song.title),
            subtitle: Text(song.artist),
            trailing: IconButton(
              icon: Icon(
                song.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: song.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                songProvider.toggleFavorite(song);
              },
            ),
          );
        },
      ),
    );
  }
}
