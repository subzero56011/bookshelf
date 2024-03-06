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
    return BlocProvider(
      create: (BuildContext context) => HomePageScreenCubit()..loadBooks(),
      child: BlocConsumer<HomePageScreenCubit, HomePageScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomePageScreenCubit.get(context);
          return Scaffold(
            backgroundColor: kSecondaryColor,
            appBar: AppBar(
              backgroundColor: kSecondaryColor,
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
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
                  onEdit: cubit.updateBook,
                );
              },
            ),
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.width * 0.22,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0)),
                  splashColor: kPrimaryColor.withOpacity(0.4),
                  backgroundColor: kAccentColor,
                  onPressed: () => showAddBookModal(context, cubit.addBook),
                  tooltip: 'Increment',
                  child: Icon(
                    Icons.add,
                    size: MediaQuery.of(context).size.width * 0.07,
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
