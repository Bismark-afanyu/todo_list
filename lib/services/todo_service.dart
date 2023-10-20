import 'package:todo/models.dart/todo.dart';

/// The TodoService class manages a list of Todo objects and provides methods to add, update, and delete
/// todos.
class TodoService {
  List<Todo> todos = [];

  void addTodo(Todo todo) {
    todos.add(todo);
  }

  void updateTodo(Todo todo) {
    final index = todos.indexWhere((t) => t.id == todo.id);
    todos[index] = todo;
  }

  void deleteTodo(String id) {
    todos.removeWhere((t) => t.id == id);
  }
}
