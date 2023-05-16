import 'package:flutter/material.dart';
import '../constants/globals.dart';
import 'game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/${Globals.mainMenuSprite}"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 50),
                //   child: Text(
                //     'Gift Grab',
                //     style: TextStyle(
                //       fontSize: 100,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 200,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GamePlay(),
                        ),
                      );
                    },
                    child: const Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
