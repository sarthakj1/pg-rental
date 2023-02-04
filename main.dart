import 'package:flutter/material.dart';

import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: const Color(0xFFF5F6F6),
        primaryColor: orangeColors,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: orangeLightColors,
        ),
        textTheme: TextTheme(
          headline1: const TextStyle(
            color: Color(0xFF100E34),
          ),
          bodyText1: TextStyle(
            color: const Color(0xFF100E34).withOpacity(0.5),
          ),
        ),
      ),
      home: const Home(
        username: " ",
      ),
    );
  }
}
