import 'package:flutter/material.dart';

void showAddBookModal(BuildContext context, Function addBookDirectly) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name;
  String? author;
  String? description;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Ensure modal is scrollable
    builder: (BuildContext bc) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Book Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a book name' : null,
                  onSaved: (value) => name = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Author'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an author name' : null,
                  onSaved: (value) => author = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onSaved: (value) => description = value,
                ),
                ElevatedButton(
                  child: const Text('Add Book'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      addBookDirectly(
                        name!,
                        author!,
                        description ?? '',
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
