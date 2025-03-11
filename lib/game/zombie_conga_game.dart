import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/components/background_parallax_component.dart';
import 'package:zombie_conga_flame/game/game.dart';

class ZombieCongaGame extends FlameGame with HasCollisionDetection {
  int score = 0;
  // final int _timeLimit = 30;
  // late Timer _timer;
  // late int _remainingTime = _timeLimit;
  // late TextComponent _scoreText;
  // late TextComponent _timeText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //debugMode = true;  //displays boxs and circles around components to help degub

    await Flame.device.setLandscape();

    //add(BackgroundComponent());
    add(MyParallaxComponent());
    add(Zombie(joystick: joystick));
    add(joystick);
    add(Cat());
    spawnCat();
    //add(EnemyComponent());

    await FlameAudio.audioCache.loadAll(
      [
        Globals.hitCatSound,
        Globals.hitEnemySound,
      ],
    );

    add(ScreenHitbox());

    // _scoreText = TextComponent(
    //   text: 'Score: $score',
    //   position: Vector2(40, 10),
    //   anchor: Anchor.topLeft,
    //   textRenderer: TextPaint(
    //     style: TextStyle(
    //       color: BasicPalette.white.color,
    //       fontSize: 30,
    //     ),
    //   ),
    // );
    //
    // add(_scoreText);
    //
    // _timeText = TextComponent(
    //   text: 'Time: $_remainingTime',
    //   position: Vector2(size.x - 40, 10),
    //   anchor: Anchor.topRight,
    //   textRenderer: TextPaint(
    //     style: TextStyle(
    //       color: BasicPalette.white.color,
    //       fontSize: 30,
    //     ),
    //   ),
    // );
    //
    // add(_timeText);
    //
    // _timer = Timer(
    //   1,
    //   repeat: true,
    //   onTick: () {
    //     if (_remainingTime == 0) {
    //       // Pause = game.
    //       pauseEngine();
    //       overlays.add(GameOverMenu.ID);
    //     } else {
    //       // Decrease time by one second.
    //       _remainingTime -= 1;
    //     }
    //   },
    // );
    //
    // _timer.start();
  } // onLoad()

  final random = Random();
  void spawnCat() {
    add(Cat());
    Timer(
      const Duration(seconds: 1) + Duration(milliseconds: random.nextInt(1000)),
      spawnCat,
    );
  }

  // dt = delta time; the time since last update

  void reset() {
    score = 0;
    // _remainingTime = _timeLimit;
  }
} // ZombieCongaGame
