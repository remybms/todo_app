import 'package:flutter/material.dart';
import 'package:todo_app/api_service.dart';

// ignore: must_be_immutable
class EditTodo extends StatelessWidget {
  final apiService = ApiService();
  String todo;
  final int idTodo;
  EditTodo({super.key, required this.todo, required this.idTodo});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Todo"),
      content: Form(
          key: formKey,
          child: SizedBox(
            width: 500,
            height: 200,
            child:  Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  initialValue: todo,
                  validator: (formTodo) {
                    if (formTodo == null || formTodo == "") {
                      return 'Please enter a task';
                    }
                    todo = formTodo;
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    apiService.editTodo(idTodo, todo, null);
                  }
                  Navigator.of(context).pop();
                },
                child: Text("Modifier cette tâche"),
              )
            ],
          )
        ),
    ));
  }
}
