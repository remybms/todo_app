import 'package:flutter/material.dart';
import 'package:todo_app/api_service.dart';

// ignore: must_be_immutable
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  child: TextFormField(
                    validator: (formTodo) {
                      if (formTodo == null || formTodo == "") {
                        return 'Please enter a task';
                      }
                      todo = formTodo;
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), fillColor: Colors.blue),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white10,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(width: 2, color: Colors.black))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      apiService.addTodo(todo, false, 1);
                      Navigator.pushNamed(context, "/");
                    }
                  },
                  child: Text("Créer une nouvelle tâche"),
                )
              ],
            )));
  }
}
