import 'dart:ui';

import 'package:flame/components.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class ApplyImageShader extends SpriteComponent //
    with
        HasGameReference<ZombieCongaGame> {
  ApplyImageShader({
    required this.shader,
    required this.color,
    super.sprite,
    super.position,
    super.size,
  });

  final FragmentShader shader;
  final Color color;

  @override
  void onLoad() {
    // Set the texture
    shader
      ..setImageSampler(0, sprite!.image)
      // Set the resolution
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      // Set the color
      ..setFloat(2, (color.r))
      ..setFloat(3, (color.g))
      ..setFloat(4, (color.b))
      ..setFloat(5, (color.a));

    paint.shader = shader;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      paint,
    );
    // super.render(canvas); // Prevents Flame from rendering it
  }
}
