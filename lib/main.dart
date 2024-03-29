import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_player_flutter/consts/colors.dart';
import 'package:music_player_flutter/home.dart';
import 'package:music_player_flutter/library.dart';
import 'package:music_player_flutter/onboarding/onboarding_screen.dart';
import 'package:music_player_flutter/playlist.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: bgDarkColor,
        primaryIconTheme: IconThemeData(
          color: whiteColor,
        ),
        useMaterial3: true,
        fontFamily: "regular",
      ),
      home: OnboardingScreen()
    );
  }
}