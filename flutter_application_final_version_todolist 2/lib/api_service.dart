import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/Task.dart';

class ApiService {
  final String _baseUrl = "https://todoapp-api.apps.k8s.gu.se";
  late final String apiKey;

  ApiService() {
    _register().then((key) => apiKey = key);
  }

  Future<String> _register() async {
    final response = await http.get(Uri.parse('$_baseUrl/register'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('$_baseUrl/todos?key=$apiKey'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/todos?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/todos/${task.id}?key=$apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/todos/$id?key=$apiKey'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
