import 'dart:convert';
import 'dart:math';

import 'package:ecommerce/components/book_model.dart';
import 'package:ecommerce/shared/network/local/chache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/screens/home_page/cubit/states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/screens/home_page/cubit/cubit.dart';
import 'package:ecommerce/components/book_model.dart';
// Import Flutter test package
import 'package:flutter_test/flutter_test.dart';
// Import bloc_test package for easier testing of Bloc and Cubit
import 'package:bloc_test/bloc_test.dart';
// Import your HomePageScreenCubit and its states
import 'package:ecommerce/screens/home_page/cubit/cubit.dart';
import 'package:ecommerce/screens/home_page/cubit/states.dart';
// Import mockito or any other mocking package if necessary
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock dependencies if necessary. For example, if you need to mock CacheHelper:

class MockCacheHelper extends CacheHelper {
  static bool mockSetStringList = true;
  static List<String>? mockGetStringList;

  static Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return mockSetStringList;
  }

  static List<String>? getStringList({
    required String key,
  }) {
    return mockGetStringList;
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await CacheHelper
        .init(); // This initializes CacheHelper with the mocked SharedPreferences
  });

  late HomePageScreenCubit cubit;
  late MockCacheHelper mockCacheHelper; // Declare the mock

  setUpAll(() {
    mockCacheHelper = MockCacheHelper();
    SharedPreferences.setMockInitialValues({});
    // Assuming CacheHelper is properly mocked to simulate shared preferences behavior
    cubit = HomePageScreenCubit(cacheHelper: mockCacheHelper);
  });

  blocTest<HomePageScreenCubit, HomePageScreenStates>(
    'adds a book and emits [HomePageScreenBookAddedState]',
    build: () => cubit,
    act: (cubit) =>
        cubit.addBook("Test Book", "Test Author", "Test Description"),
    expect: () => [
      isA<HomePageScreenBookAddedState>()
    ], // Updated to match the expected state
    verify: (_) {
      expect(cubit.books.isNotEmpty, isTrue);
      expect(cubit.books.any((book) => book.name == "Test Book"), isTrue);
    },
  );
}

class HomePageScreenCubit extends Cubit<HomePageScreenStates> {
  final CacheHelper cacheHelper; // Add this
  HomePageScreenCubit({required this.cacheHelper})
      : super(HomePageScreenInitialState());

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

  void saveBooks() {
    List<String> booksJson =
        books.map((book) => json.encode(book.toJson())).toList();
    CacheHelper.setStringList(key: 'books', value: booksJson);
  }

  static HomePageScreenCubit get(context) => BlocProvider.of(context);

  List<Book> books = [];

  void handleCheckboxChanged(bool? value, Book book) {
    book.isRead = value!;

    saveBooks();
    emit(HomePageScreenCheckboxChangedState());
  }

  void addBook(String name, String author, String description) {
    final newBook = Book(
      id: generateId(),
      name: name,
      author: author,
      description: description,
    );
    print(newBook.id);
    books.add(newBook);
    saveBooks();
    emit(HomePageScreenBookAddedState());
  }

  void deleteBook(Book deletedBook) {
    books.removeWhere((book) => book.id == deletedBook.id);
    print(deletedBook.id);
    saveBooks();
    emit(HomePageScreenBookDeletedState());
  }

//robustness against duplicates ids
  String generateId() {
    var rng = Random();
    return DateTime.now().millisecondsSinceEpoch.toString() +
        rng.nextInt(999999).toString();
  }

  void updateBook(Book updatedBook) {
    int index = books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      books[index] = updatedBook;
      saveBooks();
      emit(HomePageScreenBookEditedState());
    }
  }
}
