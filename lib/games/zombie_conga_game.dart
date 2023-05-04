import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:zombie_conga_flame/components/cat_component.dart';
//import 'package:flame/src/components/core/component.dart';
//import '../components/background_component.dart';
import '../components/zombie_component.dart';
import '../constants/globals.dart';
import '../inputs/joystick.dart';
import '../components/background_parallax_component.dart';

class ZombieCongaGame extends FlameGame with HasCollisionDetection {
  int score = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //add(BackgroundComponent());
    add(MyParallaxComponent());
    add(ZombieComponent(joystick: joystick));
    add(joystick);
    add(CatComponent());

    await FlameAudio.audioCache.loadAll(
      [
        Globals.hitCatSound,
      ],
    );
  }
}
