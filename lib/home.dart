import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_flutter/controllers/player_controller.dart';
import 'package:music_player_flutter/library.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'consts/colors.dart';
import 'consts/text_style.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _audioQuery = OnAudioQuery();
  final _controller = PlayerController();
  final _playerController = PlayerController();

  @override
  void initState() {
    _playerController.checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      // appBar: AppBar(
      //   backgroundColor: bgDarkColor,
      //   title: Text("Home",
      //   style: ourStyle(family: 'bold',color: whiteColor),),
      // ),
      body:Center(
        child: Text("Home",
          style: ourStyle(family: 'bold',color: whiteColor),),
      ),
    );
  }
}
