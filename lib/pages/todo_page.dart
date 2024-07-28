import 'package:flutter/material.dart';
import 'package:flutter_todo/data/database.dart';
import 'package:flutter_todo/utils/dialog_box.dart';
import 'package:flutter_todo/data/todo.dart';
import 'package:flutter_todo/utils/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController textFieldController = TextEditingController();

  final db = TodoDb();

  String errorMessage = "";

  void createNewTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: textFieldController,
          errorMessage: errorMessage,
          onCancel: () => Navigator.of(context).pop(),
          onSave: addTodo,
        );
      },
    );
  }

  void addTodo() {
    String message = "";
    if (textFieldController.text == "") {
      message = "Task is missing..";
    } else {
      setState(() {
        db.addTodo(Todo(textFieldController.text, false));
      });
      Navigator.of(context).pop();
    }

    setState(() {
      errorMessage = message;
    });
  }

  void updateTaskStatus(isChecked, index) {
    setState(() {
      db.updateTodo(index, isChecked);
    });
  }

  void deleteTodo(index) {
    setState(() {
      db.deleteTodo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTodo,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView.builder(
            itemCount: db.getTodos().length,
            itemBuilder: (context, index) {
              return TodoTile(
                task: db.getTodos()[index].task,
                isComplete: db.getTodos()[index].isComplete,
                onChanged: (value) => updateTaskStatus(value, index),
                onDelete: (context) => deleteTodo(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
