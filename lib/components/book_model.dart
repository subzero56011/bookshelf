import 'package:flutter/material.dart';

import 'dart:convert';

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

  // Convert a Book object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
      'isRead': isRead,
    };
  }

  // Create a Book object from a map
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      isRead: json['isRead'],
    );
  }
}

class BookListItem extends StatelessWidget {
  final Book book;
  final Function(bool?, Book) onChanged;
  final Function(Book) onDelete;
  final Function(Book) onEdit; // Add an onEdit callback

  const BookListItem({
    super.key,
    required this.book,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit, // Require the onEdit callback in the constructor
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
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
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
