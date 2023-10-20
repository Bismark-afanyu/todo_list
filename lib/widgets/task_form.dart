import 'package:flutter/material.dart';
import 'package:todo/constanst/colors.dart';

import 'package:todo/models.dart/todo.dart';

class TaskFormCard extends StatefulWidget {
  final Function(Todo) onSave;

  const TaskFormCard({super.key, required this.onSave});

  @override
  _TaskFormCardState createState() => _TaskFormCardState();
}

class _TaskFormCardState extends State<TaskFormCard> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  /// The dispose function is used to clean up resources such as controllers in Dart.
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  /// The _submitForm function creates a new Todo object with the provided title and description.
  void _submitForm() {
    Todo todo = Todo(
      id: UniqueKey().toString(),
      title: titleController.text,
      description: descriptionController.text,
      //taskTag: tagController.text,
    );

    widget.onSave(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(),
                title: const Center(
                  child: Text(
                    'New Task',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold, color: tdbrown),
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.list_alt_outlined,
                            color: tdbrown,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: 'Task',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.message_rounded,
                            color: tdbrown,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: 'Description',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.bookmark_border_rounded,
                            color: tdbrown,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(15),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: 'Add a Task Tag',
                              ),
                              items: ['Work', 'School', 'Others']
                                  .map((tag) => DropdownMenuItem<String>(
                                        value: tag,
                                        child: Text(tag),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: tdGrey,
                                shape: const RoundedRectangleBorder()),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: tdBGColor),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: tdbrown,
                                shape: const RoundedRectangleBorder()),
                            onPressed: () {
                              _submitForm();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: tdBGColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Text('Open Task Form'),
      ),
    );
  }
}
