import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import '../constants/globals.dart';
import '../games/zombie_conga.dart';

class MyParallaxComponent extends ParallaxComponent<ZombieConga> {
  @override
  Future<void> onLoad() async {
    /* from iOS version
    for i in 0...1 {
      let background = backgroundNode()
      background.anchorPoint = CGPoint.zero
      background.position =
        CGPoint(x: CGFloat(i)*background.size.width, y: 0)
      background.name = "background"
      background.zPosition = -1
      addChild(background)
    }
    */

    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData(Globals.backgroundParallaxSprite1),
      ],
      // Repeat the image in both the x and y directions until the box is filled.
      repeat: ImageRepeat.repeat,
      // baseVelocity: Sets scrolling direction based on (x, y) where
      // x is horizontal and y is vertical. Negative goes left to right or
      // top to bottom. So (40, 0) scrolls from right to left.
      baseVelocity: Vector2(40, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
  }
}
