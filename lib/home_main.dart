import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_player_flutter/playlist.dart';

import 'consts/colors.dart';
import 'consts/text_style.dart';
import 'drawer/drawer__screen.dart';
import 'home.dart';
import 'library.dart';

class MainHome extends StatefulWidget {
  MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Home(),
    LibraryScreen(),
    FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "regular",
        primaryColor: whiteColor,
          primaryColorDark: slideColor,
          iconTheme: IconThemeData(color: whiteColor)// Use the defined whiteColor here
      ),
      home: Scaffold(
        drawer:  Drawer(
          backgroundColor: bgDarkColor,
          child: DrawerScreen(),
        ),
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text('Library',style: TextStyle(color: whiteColor),),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Get.to(FavoritesScreen());
              },
            ),
          ],
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12)
          ),
          child: BottomNavigationBar(
            selectedItemColor: Color(0xFFFF3022),
            unselectedItemColor: Colors.grey,
            backgroundColor: bgDarkColor,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.double_music_note),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_note_list),
                label: 'Playlist',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
