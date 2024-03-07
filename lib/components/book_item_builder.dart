import 'package:ecommerce/components/book_model.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final Function(bool?, Book) onChanged;
  final Function(Book) onDelete;
  final onEdit;

  const BookListItem({
    super.key,
    required this.book,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(book.id.toString()),
      onDismissed: (direction) {
        onDelete(book);
      },
      background: Container(
        color: Colors.red,
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
        leading: Image.asset(
          'assets/images/book.png',
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.width * 0.22,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                onEdit(book);
              },
            ),
            Checkbox(
              value: book.isRead,
              onChanged: (bool? value) {
                onChanged(value, book);
              },
            ),
          ],
        ),
        // Add Edit actions later
      ),
    );
  }
}
