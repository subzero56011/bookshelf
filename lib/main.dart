import 'package:ecommerce/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import 'screens/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bookshelf',
        home: const MyHomePage(title: 'BookShelf'),
        theme: ThemeData(
          // Color scheme setup
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: kPrimaryColor,
            secondary: kSecondaryColor,
          ),

          // Applying custom font family across the entire app

          fontFamily: 'Lato-Bold',

          // Define the default `TextTheme`
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 30.0,
                color: kPrimaryColor,
                fontFamily: 'Lato-Bold'), // For large display text
            titleMedium: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                color: kSecondaryColor,
                fontFamily: 'Lato-Bold'), // Medium titles
            bodyMedium: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Lato-Bold',
                color: kAccentColor), // For body text
          ),
        ));
  }
}
