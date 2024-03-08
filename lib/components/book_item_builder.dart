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
        background: backgroundDeleteWidget(),
        secondaryBackground: backgroundDeleteWidget(),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width * 0.18,
                  height: screenSize.height * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/images.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book.name,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: screenSize.width * 0.033,
                                  ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          book.author,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: kPrimaryColor.withOpacity(0.7),
                                    fontSize: screenSize.width * 0.029,
                                  ),
                        ),
                        if (book.description?.isNotEmpty ?? false)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                book.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: kPrimaryColor.withOpacity(0.6),
                                      fontSize: screenSize.width * 0.029,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        onEdit(book);
                      },
                    ),
                    Checkbox(
                      checkColor: kPrimaryColor,
                      activeColor: kAccentColor,
                      value: book.isRead,
                      onChanged: (bool? value) {
                        onChanged(value, book);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backgroundDeleteWidget() {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: AlignmentDirectional.centerEnd,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
