import 'package:flutter/material.dart';
import 'package:todo/constanst/colors.dart';
import 'package:todo/models.dart/todo.dart';
import 'package:todo/widgets/task_card.dart';
import 'package:todo/widgets/task_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isAddingTask = false;
  final List<Todo> _todos = [];

  /// The function toggles the value of the _isAddingTask variable.
  void _toggleAddingTask() {
    setState(() {
      _isAddingTask = !_isAddingTask;
    });
  }

  /// The `_addTodo` function adds a `Todo` object to a list of todos and updates the state.
  /// 
  /// Args:
  ///   todo (Todo): The parameter "todo" is of type "Todo", which represents a single task or item to
  /// be added to a list of todos.
  void _addTodo(Todo todo) {
    setState(() {
      _todos.add(todo);
      _toggleAddingTask();
      //_showSnackBar('Task added');
    });
  }

  /// The function deletes a todo item from a list of todos based on its id.
  /// 
  /// Args:
  ///   id (String): The "id" parameter is a String that represents the unique identifier of the todo
  /// item that needs to be deleted.
  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
      //_showSnackBar('Task deleted');
    });
  }

  void _updateTodo(Todo todo) async {
    // Show a dialog to get the updated task details
    Todo? updatedTodo = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedTitle = todo.title;
        String updatedDescription = todo.description;
        //String updatedTaskTag = todo.taskTag;

        return AlertDialog(
          shape: Border.all(),
          title: const Center(
              child: Text('Update Task',
                  style: TextStyle(
                      color: tdbrown, fontSize: 20, fontWeight: FontWeight.bold))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.list_alt_rounded,
                    color: tdbrown,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        updatedTitle = value;
                      },
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                          //labelText: 'Title',
                          ),
                      controller: TextEditingController(text: updatedTitle),
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
                    Icons.textsms_outlined,
                    color: tdbrown,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        updatedDescription = value;
                      },
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                          //labelText: 'Description',
                          ),
                      controller: TextEditingController(text: updatedDescription),
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
                    Icons.bookmark_border_outlined,
                    color: tdbrown,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(15),
                      //value: updatedTaskTag,
                      onChanged: (value) {
                        // updatedTaskTag = value!;
                      },
                      items: ['Work', 'School', 'Others']
                          .map((tag) => DropdownMenuItem<String>(
                                value: tag,
                                child: Text(tag),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        hintText: 'Task Tag',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: tdGrey, shape: const RoundedRectangleBorder()),
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
                  backgroundColor: tdbrown, shape: const RoundedRectangleBorder()),
              onPressed: () {
                Todo updatedTodo = Todo(
                  id: todo.id,
                  title: updatedTitle,
                  description: updatedDescription,
                  //taskTag: updatedTaskTag,
                );
                Navigator.pop(context, updatedTodo);
              },
              child: const Text(
                'Update',
                style: TextStyle(color: tdBGColor),
              ),
            ),
          ],
        );
      },
    );

    /// This code block is checking if the `updatedTodo` object is not null. If it is not null, it means
    /// that the user has provided updated details for the task.
    if (updatedTodo != null) {
      setState(() {
        int index = _todos.indexWhere((t) => t.id == todo.id);
        if (index != -1) {
          _todos[index] = updatedTodo;
          //_showSnackBar('Task updated');
        }
      });
    }
  }

  // void _showSnackBar(String message) {
  //   _scaffoldKey.currentState?.showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.calendar_month_outlined,
              color: tdBGColor,
            ),
          )
        ],
        title: const Text(
          'To-Do List',
          style: TextStyle(color: tdBGColor),
        ),
        backgroundColor: tdbrown,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          Todo todo = _todos[index];
          return TaskCard(
            todo: todo,
            onDelete: () => _deleteTodo(todo.id),
            onUpdate: _updateTodo,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAddingTask,
        backgroundColor: tdbrown,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        child: const Icon(
          Icons.add,
          color: tdBGColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: tdBGColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              icon: const Icon(Icons.list_alt_rounded),
              color: _currentIndex == 0 ? tdbrown : tdbrown,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              icon: const Icon(Icons.bookmark_border),
              color: _currentIndex == 1 ? tdbrown : tdbrown,
            ),
          ],
        ),
      ),
      bottomSheet: _isAddingTask
          ? TaskFormCard(
              onSave: _addTodo,
            )
          : null,
    );
  }
}
