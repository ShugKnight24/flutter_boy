import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  const Snake({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake'),
      ),
      body: Center(
        child: const Text('Snake Game Coming Soon!'),
      ),
    );
  }
}
