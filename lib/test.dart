import 'package:ecommerce/components/book_model.dart';
import 'package:ecommerce/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final Function(bool?, Book) onChanged;
  final Function(Book) onDelete;
  final Function(Book) onEdit;

  const BookListItem({
    super.key,
    required this.book,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Dismissible(
        key: Key(book.id.toString()),
        onDismissed: (direction) {
          onDelete(book);
        },
        secondaryBackground: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.red,
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          elevation: 5,
          child: ListTile(
            leading: Material(
              borderRadius: BorderRadius.circular(4.0),
              elevation: 5.0,
              color: Colors.red,
              child: Image.asset(
                'assets/images/images.jpeg', // Update this path to your book cover image
                height: 250,
                fit: BoxFit
                    .cover, // Use BoxFit.cover to fill the box without distortion
              ),
            ),
            title: Text(
              book.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: kPrimaryColor,
                    fontSize: screenSize.width *
                        0.033, // Adjust font size based on screen width
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.author,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kPrimaryColor.withOpacity(0.7),
                        fontSize: screenSize.width *
                            0.029, // Adjust font size based on screen width
                      ),
                ),
                if (book.description?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      book.description!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kPrimaryColor.withOpacity(0.6),
                            fontSize: screenSize.width *
                                0.029, // Adjust font size based on screen width
                          ),
                    ),
                  ),
              ],
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
          ),
        ),
      ),
    );
  }
}
