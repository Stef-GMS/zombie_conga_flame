import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import '../components/zombie_component.dart';
//import 'package:zombie_conga_flame/components/zombie_component_afterRoi.dart';
import 'package:zombie_conga_flame/components/cat_component.dart';
//import 'package:zombie_conga_flame/components/cat_component_withspawning.dart';
//import 'package:zombie_conga_flame/components/enemy_component.dart';
import '../constants/globals.dart';
import '../inputs/joystick.dart';
import '../components/background_parallax_component.dart';
import '../screens/gave_over_menu.dart';

class ZombieCongaGame extends FlameGame with HasCollisionDetection {
  int score = 0;
  final int _timeLimit = 30;

  late Timer _timer;

  late int _remainingTime = _timeLimit;
  late TextComponent _scoreText;
  late TextComponent _timeText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //debugMode = true;  //displays boxs and circles around components to help degub

    Flame.device.setLandscape();

    //add(BackgroundComponent());
    add(MyParallaxComponent());
    add(ZombieComponent(joystick: joystick));
    //add(ZombieComponentSpawning(joystick: joystick));
    add(joystick);
    add(CatComponent());
    //add(CatComponentSpawning());
    //spawnCat();
    //add(EnemyComponent());

    await FlameAudio.audioCache.loadAll(
      [
        Globals.hitCatSound,
        Globals.hitEnemySound,
      ],
    );

    add(ScreenHitbox());

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(40, 10),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: 30,
        ),
      ),
    );

    add(_scoreText);

    _timeText = TextComponent(
      text: 'Time: $_remainingTime',
      position: Vector2(size.x - 40, 10),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: 30,
        ),
      ),
    );

    add(_timeText);

    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          // Pause = game.
          pauseEngine();
          overlays.add(GameOverMenu.ID);
        } else {
          // Decrease time by one second.
          _remainingTime -= 1;
        }
      },
    );

    _timer.start();
  } // onLoad()

  // spawnCat() {
  //   add(CatComponent());
  //   Timer(Duration(milliseconds: Random().nextInt(1000) + 1000), spawnCat);
  // }

  // dt = delta time; the time since last update
  @override
  void update(double dt) {
    super.update(dt);

    _timer.update(dt);

    _scoreText.text = 'Score: $score';
    _timeText.text = 'Time: $_remainingTime secs';
  }

  void reset() {
    score = 0;
    _remainingTime = _timeLimit;
  }
} // ZombieCongaGame
