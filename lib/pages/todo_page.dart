import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController textFieldController = TextEditingController();

  List todos = [];
  String errorMessage = "";

  void addTodo() {
    String message = "";
    if (textFieldController.text == "") {
      message = "Task is missing..";
    }

    setState(() {
      errorMessage = message;
    });
  }

  void updateTaskStatus(isChecked, index) {
    todos[index].isComplete = isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  TextField(
                    controller: textFieldController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ("Task"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addTodo,
                    child: const Text("Add"),
                  ),
                ],
              ),
              Text(errorMessage),
              ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    task: todos[index].task,
                    isComplete: todos[index].isComplete,
                    onChanged: (value) => updateTaskStatus(value, index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
