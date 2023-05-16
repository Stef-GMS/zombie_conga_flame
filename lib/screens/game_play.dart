import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../games/zombie_conga_game.dart';
import 'gave_over_menu.dart';

ZombieCongaGame _zombieCongaGame = ZombieCongaGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameWidget(
          game: _zombieCongaGame,
          overlayBuilderMap: {
            GameOverMenu.ID: (
              BuildContext context,
              ZombieCongaGame gameRef,
            ) =>
                GameOverMenu(gameRef: gameRef),
          },
        ),
      ),
    );
  }
}
