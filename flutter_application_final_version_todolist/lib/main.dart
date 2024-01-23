import 'package:flutter/material.dart';
import 'models/Task.dart';
import 'TodoItem.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLS055 Todo List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Task> _tasks = [];
  String filterType = "all"; // ["all", "done", "undone"]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CLS055 Todo List'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                filterType = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "all",
                child: Text('All Tasks'),
              ),
              const PopupMenuItem<String>(
                value: "done",
                child: Text('Done'),
              ),
              const PopupMenuItem<String>(
                value: "undone",
                child: Text('Undone'),
              ),
            ],
          ),
        ],
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _navigateToAddTaskPage,
      ),
    );
  }

  Widget _buildTaskList() {
    List<Task> filteredTasks = _tasks;
    if (filterType == "done") {
      filteredTasks = _tasks.where((task) => task.isDone).toList();
    } else if (filterType == "undone") {
      filteredTasks = _tasks.where((task) => !task.isDone).toList();
    } else {
      filteredTasks = _tasks;
    }

   return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            filteredTasks[index].title,
            style: filteredTasks[index].isDone
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey)
                : null,
          ),
          leading: Checkbox(
            value: filteredTasks[index].isDone,
            onChanged: (newValue) {
              setState(() {
                filteredTasks[index].isDone = newValue!;
              });
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _tasks.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }


  void _navigateToAddTaskPage() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddTaskPage(
        onTaskAdded: (String taskTitle) {
          if (taskTitle.isNotEmpty) {
            setState(() {
              _tasks.add(Task(title: taskTitle));
            });
          }
        },
      ),
    ),
  );
}


  void _selectAllTasks() {
    setState(() {
      for (var task in _tasks) {
        task.isDone = true;
      }
    });
  }

  void _viewAllDone() {
    setState(() {
      filterType = "done";
    });
  }

  void _viewUndone() {
    setState(() {
      filterType = "undone";
    });
  }
}

