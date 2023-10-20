import 'package:flutter/material.dart';
import 'package:todo/models.dart/todo.dart';

class TaskCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final void Function(Todo) onUpdate;

  const TaskCard(
      {super.key, required this.todo, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(),
      child: ListTile(
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              onDelete();
            } else if (value == 'update') {
              onUpdate(todo);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'update',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
