import 'package:flame/components.dart';
import '../constants/globals.dart';
import '../games/zombie_conga_game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<ZombieConga> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.backgroundParallaxSprite1);
    size = gameRef.size;
  }
}
