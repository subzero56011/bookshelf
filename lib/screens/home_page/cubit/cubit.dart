import 'package:ecommerce/components/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/screens/home_page/cubit/states.dart';

class HomePageScreenCubit extends Cubit<HomePageScreenStates> {
  HomePageScreenCubit() : super(HomePageScreenInitialState());

  static HomePageScreenCubit get(context) => BlocProvider.of(context);

  final List<Book> books = [
    Book(
        id: '1',
        name: 'Book 1',
        author: 'Author 1',
        description: 'Description 1'),
    Book(
        id: '2',
        name: 'Book 2',
        author: 'Author 2',
        description: 'Description 2'),
    // Add more books here
  ];

  void handleCheckboxChanged(bool? value, Book book) {
    // Update the isRead property of the book
    book.isRead = value!;
    emit(HomePageScreenCheckboxChangedState());
  }

  void deleteBook(Book deletedBook) {
    final index = books.indexWhere((book) => book.id == deletedBook.id);

    print(deletedBook.id);
    if (index != -1) {
      // Remove the book from the list
      books.removeAt(index);
      // Emit a state to notify the UI about the deletion
      emit(HomePageScreenBookDeletedState());
    }
  }

  void addBook(String name, String author, String description) {
    final newBook = Book(
      id: '${books.length + 1}',
      name: name,
      author: author,
      description: description,
    );
    books.add(newBook);
    emit(HomePageScreenBookAddedState());
  }
}
