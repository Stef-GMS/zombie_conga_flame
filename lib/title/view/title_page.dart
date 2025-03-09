import 'package:flutter/material.dart';
import 'package:zombie_conga_flame/game/game.dart';
import 'package:zombie_conga_flame/l10n/l10n.dart';
import 'package:zombie_conga_flame/loading/view/game_play.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TitlePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/MainMenu.png'),
            fit: BoxFit.fill, // template had .cover and when resizing it didn't fit right
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    // width: 200,
                    // height: 50,
                    child: ElevatedButton(
                      //style: Color(0xFFFFD54F),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (context) => const GamePlay(),
                          ),
                        );
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: SizedBox(
        width: 250,
        height: 64,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              GamePage.route(),
            );
          },
          child: Center(child: Text(l10n.titleButtonStart)),
        ),
      ),
    );
  }
}
