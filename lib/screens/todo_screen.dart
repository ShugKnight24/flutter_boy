import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todos = ref.watch<List<Todo>>(todoProvider);
    final TodoNotifier todoNotifier =
        ref.read<TodoNotifier>(todoProvider.notifier);
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Add a todo',
              ),
              onSubmitted: (String value) {
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
          // TODO: Abstract into a Todo widget
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final Todo todo = todos[index];
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
                    children: <Widget>[
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
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: editController,
            onSubmitted: (String value) {
              if (value.isNotEmpty) {
                todoNotifier.editTodoAt(index, value);
                Navigator.pop<Object?>(context);
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (editController.text.isNotEmpty) {
                  todoNotifier.editTodoAt(index, editController.text);
                }
                Navigator.pop<Object?>(context);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop<Object?>(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
