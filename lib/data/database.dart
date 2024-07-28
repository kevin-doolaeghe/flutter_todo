import 'package:flutter_todo/data/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoDb {
  final _todos = Hive.box('todoBox');

  List<Todo> getTodos() {
    List<Todo> todos = [];
    for (var todo in _todos.values) {
      todos.add(Todo(todo[0], todo[1]));
    }
    return todos;
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(int index, bool isComplete) {
    _todos.getAt(index)[1] = isComplete;
  }

  void deleteTodo(int index) {
    _todos.deleteAt(index);
  }
}
