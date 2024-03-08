import 'package:ecommerce/shared/network/local/chache_helper.dart';
import 'package:ecommerce/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import 'screens/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'bookshelf',
        home: const MyHomePage(title: 'Book Shelf'),
        theme: ThemeData(
          // Color scheme setup

          // Applying custom font family across the entire app

          fontFamily: 'Lato-Bold',

          // Define the default `TextTheme`
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 30.0,
                color: kSecondaryColor,
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
