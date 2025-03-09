import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/entities/zombie/zombie.dart';
import 'package:zombie_conga_flame/game/utilities/apply_image_shader.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class Cat extends SpriteComponent //
    with
        HasGameRef<ZombieCongaGame>,
        CollisionCallbacks {
  final double _spriteHeight = 156;
  final double _spriteWidth = 146;

  final Random _random = Random();

  Zombie? zombie;

  int trainLocation = -1;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.catSprite);

    height = _spriteHeight / 2.5;
    width = _spriteWidth / 2.5;
    position = _getRandomPosition();
    anchor = Anchor.center;

    add(CircleHitbox());

    Timer(
      Duration(milliseconds: Random().nextInt(3000) + 5000),
      removeCat,
    );

    // position = gameRef.size / 2;
  }

  void removeCat() {
    if (!captured) {
      removeFromParent();
    }
  }

  bool get captured {
    return zombie != null;
  }

  @override
  void update(dt) {
    super.update(dt);
    if (captured) {
      position.y = zombie!.position.y;
      position.x = zombie!.position.x - 50 - (trainLocation * 15);
      //zombie!.opacity = 0.5;
    }
  }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) //
  async {
    super.onCollision(intersectionPoints, other);

    if (captured) {
      return;
    }

    if (other is Zombie) {
      zombie = other;

      FlameAudio.play(Globals.hitCatSound);

      zombie!.catCount += 1;

      // add(
      //   ColorEffect(
      //     // Colors.green,
      //     const Color(0xFF00FF00),
      //     opacityFrom: 0.1,
      //     opacityTo: 0.5,
      //     //const Offset(0, 0.9),
      //     EffectController(
      //       duration: 0.2,
      //       alternate: false,
      //     ),
      //   ),
      // );

      // Using Shader to get color to match SpriteKit app.  When using an image
      // that is not transparent.  The existing color, in this case white is
      // colored with value sent to Shader.
      final fragmentProgram = await FragmentProgram.fromAsset('assets/shaders/my_shader.frag');

      await add(
        ApplyImageShader(
          shader: fragmentProgram.fragmentShader(),
          color: const Color.fromARGB(255, 0, 255, 0),
          sprite: await Sprite.load('cat.png'),
          // position: Vector2.all(0),
          // position: Vector2(width, height),
          size: Vector2(width, height),
        ),
      );

      trainLocation = zombie!.catCount;
      //parent!.addToParent(this);

      //removeFromParent(); //
      gameRef.score += 1;
      gameRef.add(Cat());
    }
  }

  Vector2 _getRandomPosition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
