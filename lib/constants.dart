import 'package:flutter/material.dart';

Color kMainColor = const Color.fromRGBO(31, 31, 31, 1.0);
String kFontFamily =  'ArchitectsDaughter';
TextStyle kQuestionTextStyle() {
  return const TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.w400,
  );
}
String apiBaseUrl = 'https://opentdb.com/api.php';