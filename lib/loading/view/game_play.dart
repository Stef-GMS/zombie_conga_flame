import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:zombie_conga_flame/game/zombie_conga_game.dart';
import 'package:zombie_conga_flame/loading/view/game_over_menu.dart';

ZombieCongaGame _zombieCongaGame = ZombieCongaGame();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _zombieCongaGame,
      overlayBuilderMap: {
        GameOverMenu.id: (
          BuildContext context,
          ZombieCongaGame gameRef,
        ) =>
            GameOverMenu(gameRef: gameRef),
      },
    );
  }
}
