import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_flutter/just_audio/audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'consts/colors.dart';
import 'consts/text_style.dart';
import 'controllers/player_controller.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final audioQuery = OnAudioQuery();
  final controller = PlayerController();
  final playerController = PlayerController();

  @override
  void initState() {
    playerController.checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgDarkColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: RefreshIndicator(
              onRefresh: () async{

              },
              child: FutureBuilder(
                future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Topilmadi'),
                    );
                  }
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Obx(
                          () => ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: bgColor,
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style: ourStyle(family: 'bold', size: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "${snapshot.data![index].artist}",
                              style: ourStyle(
                                family: 'regular',
                                size: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                size: 32,
                                color: Color(0xFFFF3022),
                              ),
                            ),
                            trailing: IconButton(
                              icon: controller.isPlaying.value
                                  ? const Icon(
                                Icons.more_vert,
                                color: Color(0xFFFF3022),
                                size: 26,
                              )
                                  : const Icon(
                                Icons.more_vert,
                                color: Color(0xFFFF3022),
                                size: 26,
                              ),
                              onPressed:  () {

                              },
                            ),
                            onTap: () {
                              Get.to(
                                  PlayerScreen(
                                    data: snapshot.data!,
                                  ),
                                  transition: Transition.downToUp);
                              controller.playSong(
                                  snapshot.data![index].uri, index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: !controller.isPlaying.value,
            child: Positioned(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: bgColor
                    ),
                    color: bgDarkColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() {
                    final songIndex = controller.playIndex.value;
                    return FutureBuilder<List<SongModel>>(
                      future: controller.audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                          return Text('Topilmadi');
                        }
                        final song = snapshot.data!.elementAt(songIndex);
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: QueryArtworkWidget(
                                id: song.id,
                                type: ArtworkType.AUDIO,
                                artworkHeight: double.infinity,
                                artworkWidth: double.infinity,
                                nullArtworkWidget: Image.asset(
                                  'assets/images/app_icon.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            song.displayNameWOExt,

                            style: ourStyle(
                                size: 12,
                                color: whiteColor,
                                family: 'bold'
                            ),
                          ),
                          subtitle: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            song.artist ?? '',
                            style: TextStyle(color: whiteColor,),
                          ),
                          trailing: Obx(() =>
                              IconButton(
                                icon: controller.isPlaying.value
                                    ? const Icon(
                                  Icons.pause_rounded,
                                  color: whiteColor,
                                  size: 26,
                                )
                                    : const Icon(
                                  Icons.play_arrow_rounded,
                                  color: whiteColor,
                                  size: 26,
                                ),
                                onPressed: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                },
                              ),
                          ),
                          onTap: () {
                            Get.to(
                              PlayerScreen(
                                data: snapshot.data!,
                              ),
                              transition: Transition.downToUp,
                            );
                          },
                        );
                      },
                    );
                  }),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
