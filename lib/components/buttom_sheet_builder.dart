import 'package:ecommerce/components/book_model.dart';
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

void showEditBookModal(
    BuildContext context, Book book, Function(Book) updateBook) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name = book.name;
  String? author = book.author;
  String? description = book.description;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // TextFormFields pre-filled with the book's current data
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Book Name'),
                onSaved: (value) => name = value,
              ),
              TextFormField(
                initialValue: author,
                decoration: InputDecoration(labelText: 'Author'),
                onSaved: (value) => author = value,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value,
              ),
              ElevatedButton(
                child: Text('Update Book'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Create an updated book object
                    Book updatedBook = Book(
                      id: book.id, // Keep the original ID
                      name: name!,
                      author: author!,
                      description: description,
                      isRead: book.isRead, // Keep the original read status
                    );
                    updateBook(
                        updatedBook); // Call the updateBook function with the updated book
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
