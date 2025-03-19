import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:zombie_conga_flame/app/view/app.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/components/background_parallax_component.dart';
// import 'package:zombie_conga_flame/game/entities/cat/cat.dart';
import 'package:zombie_conga_flame/game/game.dart';

class ZombieCongaGame extends FlameGame with HasCollisionDetection {
  int cats = 0;
  int lives = 5;
  // final int _timeLimit = 30;
  // late Timer _timer;
  // late int _remainingTime = _timeLimit;

  /// Text UI component for keeping track of score
  final TextComponent _catCount = // Configure TextComponent
      TextComponent(
    //text: '',  // text will be set later
    position: Vector2(5, 0),
    anchor: Anchor.topLeft,
    textRenderer: TextPaint(
      style: TextStyle(
        color: BasicPalette.white.color,
        fontSize: 50,
      ),
    ),
  );

  /// Text UI component for keeping track of score
  final TextComponent _livesCount = // Configure TextComponent
      TextComponent(
    //text: '',  // text will be set later
    position: Vector2(width - 50, 0),
    anchor: Anchor.topRight,
    textRenderer: TextPaint(
      style: TextStyle(
        color: BasicPalette.white.color,
        fontSize: 50,
      ),
    ),
  );

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
    //       fontSize: 50,
    //     ),
    //   ),
    // );

    //_scoreText.text = '2 Score new: $score';

    // Add Score TextComponent.
    add(_catCount);

    // Add Score TextComponent.
    add(_livesCount);
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

  @override
  void update(double dt) {
    super.update(dt);

    //print(' 33333 deviceSize: $deviceSize, width: $width');

    _catCount.text = 'Cats: $cats';

    if (lives < 5) {
      _livesCount.textRenderer = TextPaint(
        style: TextStyle(
          color: BasicPalette.orange.color,
          fontSize: 50,
        ),
      );
    }

    _livesCount
      ..text = 'Lives: $lives'
      ..position = Vector2(width - 20.0, 0);
  }

  void reset() {
    cats = 0;
  }
} // ZombieCongaGame
