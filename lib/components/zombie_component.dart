import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../constants/globals.dart';
import '../games/zombie_conga_game.dart';

enum MovementState {
  idle,
  move1,
  move2,
  move3,
}

class ZombieComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<ZombieCongaGame> {
  /// Zombie height and width
  final double _spriteWidth = 314;
  final double _spriteHeight = 204;

  /// Max speed Zombie will move
  final double _speed = 500;

  /// Joystick for moving Zombie
  JoystickComponent joystick;

  /// Device boundaries
  late double _leftBound;
  late double _rightBound;
  late double _upBound;
  late double _downBound;

  ZombieComponent({required this.joystick});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Sprites
    Sprite zombieIdle = await gameRef.loadSprite(Globals.zombieIdle);
    Sprite zombieMove1 = await gameRef.loadSprite(Globals.zombieMove1);
    Sprite zombieMove2 = await gameRef.loadSprite(Globals.zombieMove2);
    Sprite zombieMove3 = await gameRef.loadSprite(Globals.zombieMove3);

    // Sprite states
    sprites = {
      MovementState.idle: zombieIdle,
      MovementState.move1: zombieMove1,
      MovementState.move2: zombieMove2,
      MovementState.move3: zombieMove3,
    };

    // Set boundaries
    _rightBound = gameRef.size.x - 45;
    _leftBound = 0 + 45;
    _upBound = 0 + 55;
    _downBound = gameRef.size.y - 85;

    current = MovementState.idle;

    // Set position to middle of screen
    position = gameRef.size / 2.0;

    // Set sprite dimensions for screen
    height = _spriteHeight / 2.5;
    width = _spriteWidth / 2.5;
    anchor = Anchor.center;

    add(CircleHitbox());
  }

  @override
  void update(dt) {
    super.update(dt);

    if (joystick.direction == JoystickDirection.idle) {
      current = MovementState.idle;
      return;
    }
    if (x >= _rightBound) {
      x = _rightBound - 1;
    }

    if (x <= _leftBound) {
      x = _leftBound + 1;
    }

    if (y <= _upBound) {
      y = _upBound + 1;
    }

    if (y >= _downBound) {
      y = _downBound - 1;
    }

    bool movingLeft = joystick.relativeDelta[0] < 0;

    if (movingLeft) {
      current = MovementState.move1;
    } else {
      current = MovementState.move2;
    }

    position.add(joystick.relativeDelta * _speed * dt);
  }
}
