import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import '../games/zombie_conga.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = ZombieConga();
  runApp(GameWidget(game: game));
}
