import 'package:flutter/material.dart';
import 'package:todo_app/api_service.dart';
import 'package:todo_app/models/todo_model.dart';

class DisplayTodo extends StatelessWidget {
  final apiService = ApiService();
  DisplayTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TodoResponse>(
        future: apiService.fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          }

          final todos = snapshot.data!.todos;
          return Expanded(
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Text(todo.todo),
                        ElevatedButton(
                            onPressed: () {
                              apiService.deleteTodo(todo.id);
                            },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                    trailing: CheckButton(isCompleted: todo.completed),
                  );
                }),
          );
        });
  }
}

class CheckButton extends StatefulWidget {
  final bool isCompleted;
  const CheckButton({super.key, required this.isCompleted});

  @override
  _CheckButton createState() => _CheckButton(isCompleted);
}

class _CheckButton extends State<CheckButton> {
  bool _isActive;
  _CheckButton(this._isActive);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      child: Icon(
        _isActive ? Icons.check_box : Icons.check_box_outline_blank,
      ),
    );
  }
}
