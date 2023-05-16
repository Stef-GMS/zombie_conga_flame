import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final game = ZombieCongaGame();
  // runApp(GameWidget(game: game));

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    ),
  );
}
