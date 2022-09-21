import 'package:flutter/material.dart';
import 'package:frivia/constants.dart';
import 'package:frivia/pages/game_page.dart';
import 'package:frivia/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        scaffoldBackgroundColor: kMainColor,
        fontFamily: kFontFamily,
      ),
      home: HomePage(),
    );
  }
}

