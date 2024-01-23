import 'package:flutter/material.dart';
import 'models/Task.dart'; 
import 'TodoItem.dart'; 
import 'api_service.dart'; 

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
  final ApiService _apiService = ApiService();
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
      body: FutureBuilder<List<Task>>(
        future: _apiService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No tasks available');
          } else {
            _tasks.clear();
            _tasks.addAll(snapshot.data!);
            return _buildTaskList();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _navigateToAddTaskPage,
      ),
    );
  }

  Widget _buildTaskList() {
    List<Task> filteredTasks = _tasks;
    if (filterType == "done") {
      filteredTasks = _tasks.where((task) => task.done).toList();
    } else if (filterType == "undone") {
      filteredTasks = _tasks.where((task) => !task.done).toList();
    }

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            filteredTasks[index].title,
            style: filteredTasks[index].done
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey)
                : null,
          ),
          leading: Checkbox(
            value: filteredTasks[index].done,
            onChanged: (newValue) {
              setState(() {
                filteredTasks[index].done = newValue!;
                _apiService.updateTask(filteredTasks[index]);
              });
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _apiService.deleteTask(filteredTasks[index].id);
                _tasks.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  void _navigateToAddTaskPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(
          onTaskAdded: (String taskTitle) {
            if (taskTitle.isNotEmpty) {
              Task newTask = Task(id: '', title: taskTitle); // 你需要创建一个不带 ID 的 Task 对象
              _apiService.addTask(newTask).then((_) => setState(() {
                _tasks.add(newTask);
              }));
            }
          },
        ),
      ),
    );
  }
}
