import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart'
    hide Timer; // hide Timer is because Flame has Timer and we want Dart one
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/entities/zombie/zombie.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class Cat extends SpriteComponent //
    with
        HasGameRef<ZombieCongaGame>,
        CollisionCallbacks {
  final double _spriteWidth = 146;
  final double _spriteHeight = 156;

  final Random _random = Random();

  Zombie? zombie;

  int trainLocation = -1;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.catSprite);
    width = _spriteWidth / 2.5;
    height = _spriteHeight / 2.5;
    position = _getRandomPosition();
    anchor = Anchor.centerRight;

    add(CircleHitbox());

    Timer(
      Duration(milliseconds: Random().nextInt(3000) + 5000),
      removeCat,
    );
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
  void update(double dt) {
    super.update(dt);
    if (captured) {
      position.y = zombie!.height * 0.5;
      position.x = 20.0 - (trainLocation * 15.0);
    }
  }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (captured) {
      return;
    }

    if (other is Zombie) {
      zombie = other;
      parent = zombie;

      trainLocation = zombie!.catCount;
      zombie!.catCount += 1;

      gameRef.score += 1;
      gameRef.add(Cat());

      FlameAudio.play(Globals.hitCatSound);

      // colorFilter has a built-in shader, so don't need to create a Shader
      getPaint().colorFilter = const ColorFilter.mode(
        Color.from(alpha: 1.0, red: 0.0, green: 1.0, blue: 0.0),
        BlendMode.modulate,
      );
    }

    super.onCollision(intersectionPoints, other);
  }

  Vector2 _getRandomPosition() {
    final x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    final y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
