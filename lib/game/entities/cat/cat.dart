import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:zombie_conga_flame/game/entities/zombie/zombie.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';
import 'package:flutter/material.dart';

import 'package:zombie_conga_flame/constants/globals.dart';

class CatComponent extends SpriteComponent with HasGameRef<ZombieCongaGame>, CollisionCallbacks {
  final double _spriteHeight = 156;
  final double _spriteWidth = 146;

  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.catSprite);

    height = _spriteHeight / 2.5;
    width = _spriteWidth / 2.5;
    position = _getRandomPosition();
    anchor = Anchor.center;

    add(CircleHitbox());

    // position = gameRef.size / 2;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ZombieComponent) {
      FlameAudio.play(Globals.hitCatSound);

      removeFromParent(); //
      add(ColorEffect(
        Colors.green,
        opacityFrom: 0.2,
        opacityTo: 0.8,
        //const Offset(0, 0.9),
        EffectController(
          duration: 0.2,
          alternate: false,
        ),
      ));

      gameRef.score += 1;
      gameRef.add(CatComponent());
    }
  }

  Vector2 _getRandomPosition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
