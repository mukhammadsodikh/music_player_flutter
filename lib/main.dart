// import 'package:flutter/material.dart';
// import 'package:music_player_flutter/playlist.dart';
// import 'package:provider/provider.dart';
// import 'controllers/song_provider.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SongProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Music Player',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: HomeScreen(),
//         routes: {
//           '/favorites': (context) => FavoritesScreen(),
//         },
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Music Player'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.pushNamed(context, '/favorites');
//             },
//           ),
//         ],
//       ),
//       body: Center(child: Text('Home Screen')),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_player_flutter/consts/colors.dart';
import 'package:music_player_flutter/onboarding/onboarding_screen.dart';
import 'package:music_player_flutter/playlist.dart';
import 'package:provider/provider.dart';

import 'controllers/song_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongProvider(),
      child: MyApp(),
    ),
  );
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