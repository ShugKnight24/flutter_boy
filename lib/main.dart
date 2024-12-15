import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './providers/todo_provider.dart';

// TODO: Begin considering how to architect & structure the app
// Domain Driven Design?
void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application Theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    TodoListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // TODO: Think of a better way to change the title
        // Especially when multiple screens are added
        title: Text(_widgetOptions[_selectedIndex] is MyHomePage
            ? 'Home'
            : 'Todo List'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todo List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  // Creates the state of the widget
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

// TODO: Create a seperate file for the TodoListScreen
class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final todoNotifier = ref.read(todoProvider.notifier);
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Add a todo',
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  todoNotifier.addTodo(value);
                  textController.clear();
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                todoNotifier.addTodo(textController.text);
                textController.clear();
              }
            },
            child: const Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (bool? value) {
                      todoNotifier.toggleTodoCompletion(index);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _editTodoAt(context, todoNotifier, index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => todoNotifier.deleteTodoAt(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editTodoAt(BuildContext context, TodoNotifier todoNotifier, int index) {
    final TextEditingController editController =
        TextEditingController(text: todoNotifier.state[index].title);

    // TODO: better to edit in line w/ a text input?
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: editController,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                todoNotifier.editTodoAt(index, value);
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  todoNotifier.editTodoAt(index, editController.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
