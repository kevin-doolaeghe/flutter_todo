import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String task;
  final bool isComplete;
  final Function(bool?)? onChanged;

  const TodoTile({
    super.key,
    required this.task,
    required this.isComplete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isComplete,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            Text(
              task,
              style: TextStyle(
                decoration: isComplete
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
