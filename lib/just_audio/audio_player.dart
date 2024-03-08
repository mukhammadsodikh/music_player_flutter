import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player_flutter/library.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../controllers/player_controller.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;

  PlayerScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/app_icon.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [bgDarkColor, bgColor],
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Obx(
              () => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 45, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(LibraryScreen());
                          },
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              CupertinoIcons.arrow_down_square_fill,


                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Container(
                      alignment: Alignment.center,
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(12)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: QueryArtworkWidget(
                          id: data[controller.playIndex.value].id,
                          type: ArtworkType.AUDIO,
                          artworkHeight: double.infinity,
                          artworkWidth: double.infinity,
                          nullArtworkWidget: Image.asset(
                            'assets/images/app_icon.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 23, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[controller.playIndex.value]
                                    .displayNameWOExt,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              Text(
                                data[controller.playIndex.value]
                                    .artist
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Obx(
                              () => Slider(
                                thumbColor: slideColor,
                                inactiveColor: bgColor,
                                activeColor: slideColor,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                      newValue.toInt());
                                  // newValue = newValue;
                                  controller.updatePosition();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.position.value,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      controller.duration.value,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.list, color: Colors.white, size: 32),
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.backward_end_fill,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value - 1].uri,
                                    controller.playIndex.value - 1);
                              },
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Obx(
                                () => CircleAvatar(
                                  backgroundColor: whiteColor,
                                  radius: 45,
                                  child: Transform.scale(
                                    scale: 2.5,
                                    child: IconButton(
                                      icon: controller.isPlaying.value
                                          ? const Icon(
                                              Icons.pause_rounded,
                                              color: bgColor,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.play_arrow_rounded,
                                              color: bgColor,
                                              size: 22,
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
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.forward_end_fill,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value + 1].uri,
                                    controller.playIndex.value + 1);
                              },
                            ),
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
