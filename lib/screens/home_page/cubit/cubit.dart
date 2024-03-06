import 'dart:convert';

import 'package:ecommerce/components/book_model.dart';
import 'package:ecommerce/shared/network/local/chache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/screens/home_page/cubit/states.dart';

class HomePageScreenCubit extends Cubit<HomePageScreenStates> {
  HomePageScreenCubit() : super(HomePageScreenInitialState());
  Future<void> init() async {
    await loadBooks;
  }

  void loadBooks() async {
    List<String>? booksJson = CacheHelper.getStringList(key: 'books');
    if (booksJson != null) {
      books = booksJson
          .map((bookJson) => Book.fromJson(json.decode(bookJson)))
          .toList();
    } else {
      books = []; // Initialize with an empty list if no saved books are found
    }
    emit(HomePageScreenBooksLoadedState());
  }

  void saveBooks() {
    List<String> booksJson =
        books.map((book) => json.encode(book.toJson())).toList();
    CacheHelper.setStringList(key: 'books', value: booksJson);
  }

  static HomePageScreenCubit get(context) => BlocProvider.of(context);

  List<Book> books = [
    // Book(
    //     id: '1',
    //     name: 'Book 1',
    //     author: 'Author 1',
    //     description: 'Description 1'),
    // Book(
    //     id: '2',
    //     name: 'Book 2',
    //     author: 'Author 2',
    //     description: 'Description 2'),
  ];

  void handleCheckboxChanged(bool? value, Book book) {
    // Update the isRead property of the book
    book.isRead = value!;

    saveBooks();
    emit(HomePageScreenCheckboxChangedState());
  }

  void addBook(String name, String author, String description) {
    final newBook = Book(
      id: '${books.length + 1}',
      name: name,
      author: author,
      description: description,
    );
    books.add(newBook);
    saveBooks();
    emit(HomePageScreenBookAddedState());
  }

  void deleteBook(Book deletedBook) {
    books.removeWhere((book) => book.id == deletedBook.id);
    saveBooks();
    emit(HomePageScreenBookDeletedState());
  }

  void updateBook(Book updatedBook) {
    // Find the index of the book to update
    int index = books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      books[index] = updatedBook; // Update the book at the found index
      saveBooks(); // Save the updated books list
      emit(HomePageScreenBookEditedState()); // Emit an updated state
    }
  }
}
