import 'package:ecommerce/components/book_item_builder.dart';
import 'package:ecommerce/components/book_model.dart';
import 'package:ecommerce/components/buttom_sheet_builder.dart';
import 'package:ecommerce/screens/home_page/cubit/cubit.dart';
import 'package:ecommerce/screens/home_page/cubit/states.dart';
import 'package:ecommerce/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => HomePageScreenCubit()..init(),
      child: BlocConsumer<HomePageScreenCubit, HomePageScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageScreenCubit.get(context);
          return Scaffold(
            backgroundColor: kSecondaryColor,
            appBar: AppBar(
              elevation: 5,
              backgroundColor: kPrimaryColor,
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: screenSize.width *
                          0.055, // Adjust font size based on screen width
                    ),
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: cubit.books.length,
              itemBuilder: (context, index) {
                final book = cubit.books[index];
                return BookListItem(
                  book: book,
                  onChanged: cubit.handleCheckboxChanged,
                  onDelete: cubit.deleteBook,
                  onEdit: (Book book) {
                    showBookModal(context,
                        book: book, updateBook: cubit.updateBook);
                  },
                );
              },
            ),
            floatingActionButton: SizedBox(
              width: screenSize.width * 0.22,
              height: screenSize.width * 0.22,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0)),
                  splashColor: kPrimaryColor.withOpacity(0.4),
                  backgroundColor: kAccentColor,
                  onPressed: () {
                    showBookModal(context, addBook: cubit.addBook);
                  },
                  tooltip: 'Increment',
                  child: Icon(
                    Icons.add,
                    size: screenSize.width * 0.07,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
