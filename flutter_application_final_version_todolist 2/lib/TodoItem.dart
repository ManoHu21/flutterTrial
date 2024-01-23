import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  final Function(String) onTaskAdded;

  AddTaskPage({required this.onTaskAdded});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CLS055 Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'What are you planning?',
              border: OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Add'), 
              onPressed: () {
                widget.onTaskAdded(_taskController.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}