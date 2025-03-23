import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/effects.dart';
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
  ZombieCongaGame() {
    zombie = Zombie(joystick: joystick);
  }

  int lives = 5;
  late Zombie zombie;

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

    //debugMode = true; //displays boxes and circles around components to help debug

    await Flame.device.setLandscape();

    await FlameAudio.audioCache.loadAll(
      [
        Globals.hitCatSound,
        Globals.hitEnemySound,
      ],
    );

    add(MyParallaxComponent());

    add(zombie);
    add(joystick);

    spawnCats();

    spawnEnemy();

    // Add Score TextComponent.
    add(_catCount);

    // Add Score TextComponent.
    add(_livesCount);
  } // onLoad()

  final _random = Random();

  void spawnCats() {
    //
    // add a cat to game
    add(Cat());

    // set a timer to spawn more cats
    Timer(
      const Duration(seconds: 1) +
          Duration(
            milliseconds: _random.nextInt(1000),
          ),
      spawnCats,
    );
  }

  void spawnEnemy() {
    final enemy = Enemy();
    final x = size.x;

    final y = _random.nextDouble() * size.y;
    enemy.position = Vector2(x, y);

    add(enemy);

    enemy.add(
      MoveToEffect(
        Vector2(
          -enemy.width,
          y,
        ),
        EffectController(duration: 3.0), // SpriteKit app had 2.0
        onComplete: () {
          enemy.removeFromParent();
          spawnEnemy();
        },
      ),
    );
  }

  // dt = delta time; the time since last update

  @override
  void update(double dt) {
    super.update(dt);

    // _catCount.text = 'Cats: ${zombie.catCountInTrain()}';
    _catCount.text = 'Cats: ${zombie.catCountInTrain}';

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
    // example of using a function
    // zombie.removeCatsFromTrain(zombie.catCountInTrain());

    // example of using a getter
    zombie.removeCatsFromTrain(zombie.catCountInTrain);

    // example of using a setter to set a zombie property
    //zombie.catCountInTrain = 100;
  }

  void catCollidesWithZombie() {
    add(Cat());
  }

  void enemyCollidesWithZombie() {
    zombie
      ..removeCatsFromTrain(2)
      ..makeInvincible();
  }
} // ZombieCongaGame
