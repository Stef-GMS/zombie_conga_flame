import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:zombie_conga_flame/game/entities/unicorn/unicorn.dart';
import 'package:zombie_conga_flame/game/game.dart';
import 'package:zombie_conga_flame/gen/assets.gen.dart';

class TappingBehavior extends Behavior<Unicorn> //
    with
        TapCallbacks,
        HasGameRef<ZombieCongaGame> {
  @override
  bool containsLocalPoint(Vector2 point) {
    return parent.containsLocalPoint(point);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (parent.isAnimationPlaying()) {
      return;
    }
    //gameRef.counter++;
    parent.playAnimation();

    //gameRef.effectPlayer.play(AssetSource(Assets.audio.effect));
  }
}
