import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super(<Todo>[]);

  void addTodo(String title) {
    state = <Todo>[
      ...state,
      Todo(
        title: title,
      )
    ];
  }

  void toggleTodoCompletion(int index) {
    state = <Todo>[
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Todo(
            title: state[i].title,
            isCompleted: !state[i].isCompleted,
          )
        else
          state[i],
    ];
  }

  void deleteTodoAt(int index) {
    state = <Todo>[
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void editTodoAt(int index, String newTitle) {
    state = <Todo>[
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Todo(
            title: newTitle,
            isCompleted: state[i].isCompleted,
          )
        else
          state[i],
    ];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});
