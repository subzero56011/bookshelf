import 'dart:convert';
import 'dart:math';

import 'package:ecommerce/components/book_model.dart';
import 'package:ecommerce/shared/network/local/chache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/screens/home_page/cubit/states.dart';

class HomePageScreenCubit extends Cubit<HomePageScreenStates> {
  HomePageScreenCubit() : super(HomePageScreenInitialState());
  Future<void> init() async {
    await loadBooks();
    if (books.isEmpty) {
      _insertDummyBooks();
    }
  }

  void _insertDummyBooks() {
    books = [
      Book(
        id: '1',
        name: 'The Great Adventure',
        author: 'Alex Reed',
        description: 'An epic journey through uncharted territories.',
        isRead: false,
      ),
      Book(
        id: '2',
        name: 'Mysteries of the Ancient World',
        author: 'Samantha Ivy',
        description:
            'Exploring the wonders and mysteries of ancient civilizations.',
        isRead: false,
      ),
      Book(
        id: '3',
        name: 'The Art of Innovation',
        author: 'John Creatives',
        description:
            'Insights into the process of innovation and creativity in the modern world.',
        isRead: false,
      ),
      Book(
        id: '4',
        name: 'Into the Depths of Space',
        author: 'Neil Starwalker',
        description:
            'A journey to the edges of the universe and the future of space exploration.',
        isRead: false,
      ),
      Book(
        id: '5',
        name: 'The Philosophy of Time',
        author: 'Elara Thorn',
        description:
            'A deep dive into the concepts of time, existence, and the universe.',
        isRead: false,
      ),
    ];

    saveBooks();
    emit(HomePageScreenBooksLoadedState());
  }

  Future<void> loadBooks() async {
    List<String>? booksJson = CacheHelper.getStringList(key: 'books');
    if (booksJson != null) {
      books = booksJson
          .map((bookJson) => Book.fromJson(json.decode(bookJson)))
          .toList();
    } else {
      books = [];
    }
    emit(HomePageScreenBooksLoadedState());
  }

  Future<void> saveBooks() async {
    List<String> booksJson =
        books.map((book) => json.encode(book.toJson())).toList();
    await CacheHelper.setStringList(key: 'books', value: booksJson);
  }

  static HomePageScreenCubit get(context) => BlocProvider.of(context);

  List<Book> books = [];

  void handleCheckboxChanged(bool? value, Book book) {
    book.isRead = value!;

    saveBooks();
    emit(HomePageScreenCheckboxChangedState());
  }

  Future<void> addBook(String name, String author, String description) async {
    final newBook = Book(
      id: generateId(),
      name: name,
      author: author,
      description: description,
    );
    print(newBook.id);
    books.add(newBook);
    await saveBooks();
    emit(HomePageScreenBookAddedState());
  }

  Future<void> deleteBook(Book deletedBook) async {
    books.removeWhere((book) => book.id == deletedBook.id);
    print(deletedBook.id);
    await saveBooks();
    emit(HomePageScreenBookDeletedState());
  }

//robustness against duplicates ids
  String generateId() {
    var rng = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        rng.nextInt(999999).toString();
  }

  Future<void> updateBook(Book updatedBook) async {
    int index = books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      books[index] = updatedBook;
      await saveBooks();
      emit(HomePageScreenBookEditedState());
    }
  }
}
