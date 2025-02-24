import 'package:flutter/material.dart';
import 'package:todo_app/api_service.dart';

class AddTodo extends StatelessWidget {
  final apiService = ApiService();
  String todo = "";
  AddTodo({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ajouter une nouvelle tâche')),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (formTodo) {
                    if (formTodo == null || formTodo == "") {
                      return 'Please enter a task';
                    }
                    todo = formTodo;
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      apiService.addTodo(todo, false, 1);
                    }
                  },
                  child: Text("Créer une nouvelle tâche"),
                )
              ],
            )));
  }
}

