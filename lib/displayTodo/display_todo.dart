import 'package:flutter/material.dart';
import 'package:todo_app/api_service.dart';
import 'package:todo_app/editTodo/edit_todo.dart';
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
                      title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            apiService.deleteTodo(todo.id);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              minimumSize: Size(30, 30),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white10,
                              shadowColor: Colors.transparent,
                              shape: CircleBorder()),
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                        CheckButton(
                            isCompleted: todo.completed, idTodo: todo.id),
                        ElevatedButton(
                          onPressed: () {},
                          onLongPress: () async {
                            await showDialog<void>(
                                context: context,
                                builder: (context) =>
                                    EditTodo(todo: todo.todo, idTodo: todo.id));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white10,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(todo.todo),
                        ),
                      ],
                    ),
                  ));
                }),
          );
        });
  }
}

class CheckButton extends StatefulWidget {
  final bool isCompleted;
  final int idTodo;
  const CheckButton(
      {super.key, required this.isCompleted, required this.idTodo});

  @override
  _CheckButton createState() => _CheckButton(isCompleted, idTodo);
}

class _CheckButton extends State<CheckButton> {
  bool _isActive;
  int idTodo;
  _CheckButton(this._isActive, this.idTodo);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        minimumSize: Size(30, 30),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white10,
        shadowColor: Colors.transparent,
        shape: CircleBorder(),
      ),
      onPressed: () {
        setState(() {
          _isActive = !_isActive;
        });
        ApiService().editTodo(idTodo, null, _isActive);
      },
      child: Icon(
        _isActive ? Icons.check_box : Icons.check_box_outline_blank,
        color: Colors.black,
      ),
    );
  }
}
