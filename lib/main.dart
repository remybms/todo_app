import 'package:flutter/material.dart';
import 'package:todo_app/addTodo/new_todo.dart';
import 'package:todo_app/api_service.dart';
import 'package:todo_app/displayTodo/display_todo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add-todo': (context) => AddTodo(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final apiService = ApiService();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('To do list')),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              child: Text('Ajouter une nouvelle tâche'),
              onPressed: () {
                Navigator.pushNamed(context, '/add-todo');
              },
            ),
            DisplayTodo()
          ],
        )
      )
    );
  }
}
