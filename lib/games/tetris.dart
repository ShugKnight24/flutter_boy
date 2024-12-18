import 'package:flutter/material.dart';

class Tetris extends StatelessWidget {
  const Tetris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tetris'),
      ),
      body: Center(
        child: const Text('Tetris Game Coming Soon!'),
      ),
    );
  }
}
