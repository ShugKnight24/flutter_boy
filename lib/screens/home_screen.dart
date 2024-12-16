import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  // Creates the state of the widget
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // setState tells Flutter to rerun the build method of this widget
      _counter++;
    });
  }

  @override
  // Build method runs every time the setState is called
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          // Array of widgets, displayed in a column
          children: <Widget>[
            // can use .tonal on FilledButton to change the color
            FilledButton(
              onPressed: _incrementCounter,
              child:
                  const Text("I'm a Filled Button that increments the counter"),
            ),
            const Text(
              'You can also press the `+` button on the bottom right to increment the counter',
            ),
            const Text(
              'You have pushed the button(s) this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
