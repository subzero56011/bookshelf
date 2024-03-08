import 'package:ecommerce/components/book_model.dart';
import 'package:ecommerce/shared/styles/colors.dart';
import 'package:flutter/material.dart';

// void showAddBookModal(BuildContext context, Function addBook) {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String? name;
//   String? author;
//   String? description;
//
//   showDialog(
//     context: context,
//     builder: (BuildContext bc) {
//       return AlertDialog(
//         content: Container(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Book Name'),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter a book name' : null,
//                   onSaved: (value) => name = value,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Author'),
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter an author name' : null,
//                   onSaved: (value) => author = value,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   onSaved: (value) => description = value,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           Center(
//             child: ElevatedButton(
//               child: const Text('Add Book'),
//               onPressed: () {
//                 if (formKey.currentState!.validate()) {
//                   formKey.currentState!.save();
//                   addBook(
//                     name!,
//                     author!,
//                     description ?? '',
//                   );
//                   Navigator.pop(context);
//                 }
//               },
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
//
// void showEditBookModal(BuildContext context, Book book, updateBook) {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? name = book.name;
//   String? author = book.author;
//   String? description = book.description;
//
//   showDialog(
//     context: context,
//     builder: (BuildContext bc) {
//       return AlertDialog(
//         content: Container(
//           padding: EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 // TextFormFields pre-filled with the book's current data
//                 TextFormField(
//                   initialValue: name,
//                   decoration: InputDecoration(labelText: 'Book Name'),
//                   onSaved: (value) => name = value,
//                 ),
//                 TextFormField(
//                   enabled: false,
//                   initialValue: author,
//                   decoration: InputDecoration(labelText: 'Author'),
//                   onSaved: (value) => author = value,
//                 ),
//                 TextFormField(
//                   initialValue: description,
//                   decoration: InputDecoration(labelText: 'Description'),
//                   onSaved: (value) => description = value,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           Center(
//             child: ElevatedButton(
//               child: Text('Update Book'),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   // Create an updated book object
//                   Book updatedBook = Book(
//                     id: book.id, // Keep the original ID
//                     name: name!,
//                     author: author!,
//                     description: description,
//                     isRead: book.isRead, // Keep the original read status
//                   );
//                   updateBook(
//                       updatedBook); // Call the updateBook function with the updated book
//                   Navigator.pop(context);
//                 }
//               },
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

void showBookModal(
  BuildContext context, {
  Book? book,
  Function(Book)? updateBook,
  Function(String, String, String)? addBook,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name = book?.name;
  String? author = book?.author;
  String? description = book?.description;

  showDialog(
    context: context,
    builder: (BuildContext bc) {
      final screenSize = MediaQuery.of(context).size;

      return AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (book != null) ...[
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(labelText: 'Book Name'),
                    onSaved: (value) => name = value,
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: author,
                    decoration: const InputDecoration(labelText: 'Author'),
                    onSaved: (value) => author = value,
                  ),
                  TextFormField(
                    initialValue: description,
                    decoration: const InputDecoration(labelText: 'Description'),
                    onSaved: (value) => description = value,
                  ),
                ] else ...[
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
                ],
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              child: Text(
                book != null ? 'Update Book' : 'Add Book',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: kPrimaryColor,
                      fontSize: screenSize.width * 0.033,
                    ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (book != null) {
                    // Update an existing book
                    Book updatedBook = Book(
                      id: book.id,
                      name: name!,
                      author: author!,
                      description: description,
                      isRead: book.isRead,
                    );
                    updateBook!(updatedBook);
                  } else {
                    // Add a new book
                    addBook!(name!, author!, description ?? '');
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      );
    },
  );
}
