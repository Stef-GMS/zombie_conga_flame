import 'package:flame/game.dart';
//import 'package:flame/src/components/core/component.dart';
//import '../components/background_component.dart';
import '../components/zombie_component.dart';
import '../inputs/joystick.dart';
import '../components/background_parallax_component.dart';

class ZombieConga extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //add(BackgroundComponent());
    add(MyParallaxComponent());
    add(ZombieComponent(joystick: joystick));
    add(joystick);
  }
}
