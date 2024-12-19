import 'package:flutter/material.dart';
import '../games/snake.dart';
import '../games/tetris.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Tetris()),
                );
              },
              child: const Text('Play Tetris'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Snake()),
                );
              },
              child: const Text('Play Snake'),
            ),
          ],
        ),
      ),
    );
  }
}
