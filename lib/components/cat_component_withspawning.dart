import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/components/zombie_component.dart';
import 'package:zombie_conga_flame/components/zombie_component_afterRoi.dart';
import 'package:zombie_conga_flame/games/zombie_conga_game.dart';

import '../constants/globals.dart';

class CatComponentSpawning extends SpriteComponent
    with HasGameRef<ZombieCongaGame>, CollisionCallbacks {
  final double _spriteHeight = 156;
  final double _spriteWidth = 146;

  final Random _random = Random();
  ZombieComponentSpawning? zombie;
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
    Timer(Duration(milliseconds: Random().nextInt(3000) + 5000), removeCat);
    // position = gameRef.size / 2;
  }

  void removeCat() {
    if (!captured) {
      removeFromParent();
    }
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

  bool get captured {
    return zombie != null;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (captured) {
      return;
    }

    if (other is ZombieComponentSpawning) {
      zombie = other;
      FlameAudio.play(Globals.hitCatSound);
      zombie!.catCount += 1;

      ColorEffect(
        Colors.green,
        const Offset(0, 0.9),
        EffectController(duration: 0.2, alternate: false),
      );
      trainLocation = zombie!.catCount;
      //parent!.addToParent(this);

      //removeFromParent(); //
      gameRef.score += 1;
      gameRef.add(CatComponentSpawning());
    }
  }

  Vector2 _getRandomPosition() {
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}
