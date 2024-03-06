import 'package:flutter/material.dart';

class Book {
  String id;
  String name;
  String author;
  String? description;
  bool isRead;

  Book({
    required this.id,
    required this.name,
    required this.author,
    this.description,
    this.isRead = false,
  });
}

class BookListItem extends StatelessWidget {
  final Book book;
  final Function(bool?, Book) onChanged;
  final Function(Book) onDelete;

  const BookListItem({
    required this.book,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(book.id.toString()), // Unique key for each Dismissible widget
      onDismissed: (direction) {
        // Call the onDelete method passed from the parent widget
        onDelete(book);
      },
      background: Container(
        color: Colors.red, // Background color when swiping to delete
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        title: Text(book.name),
        subtitle: Text(book.author),
        trailing: Checkbox(
          value: book.isRead,
          onChanged: (bool? value) {
            // Call the onChanged method passed from the parent widget
            onChanged(value, book);
          },
        ),
        // Add Edit actions later
      ),
    );
  }
}
