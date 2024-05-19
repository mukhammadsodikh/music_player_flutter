import 'package:flutter/material.dart';
import 'package:music_player_flutter/consts/colors.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/song_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongProvider>(context);

    return Scaffold(
      backgroundColor: bgColor,
      body: FutureBuilder(
        future: songProvider.fetchSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final favoriteSongs = songProvider.songs
                .where((song) => song.isFavorite.value)
                .toList();

            if (favoriteSongs.isEmpty) {
              return Center(child: Text('No favorite songs'));
            }

            return ListView.builder(
              itemCount: favoriteSongs.length,
              itemBuilder: (context, index) {
                final song = favoriteSongs[index];
                return ListTile(
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Icon(Icons.music_note),
                  ),
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  trailing: IconButton(
                    icon: Icon(
                      song.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                      color: song.isFavorite.value ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      songProvider.toggleFavorite(song);
                    },
                  ),
                  onTap: () {
                    // Handle song play or other actions
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
