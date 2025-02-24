import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/todo_model.dart';

class ApiService {
  final String baseUrl = 'https://dummyjson.com/todos';

  Future<TodoResponse> fetchTodos() async {
    final response = await http.get(Uri.parse("$baseUrl?limit=0"));
    if (response.statusCode == 200) {
      return TodoResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> addTodo(String todo, bool completed, int idUser) async {
    final response = await http.post(Uri.parse("$baseUrl/add"), headers: {'Content-Type': 'application/json'}, body: jsonEncode({
      'todo': todo,
      'completed': completed,
      'userId': idUser,
    })
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<TodoDelete> deleteTodo(int idTodo) async {
    final response = await http.delete(Uri.parse("$baseUrl/$idTodo"));
    if (response.statusCode == 200){
      return TodoDelete.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}