import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frivia/constants.dart';
import 'package:frivia/pages/home_page.dart';

class GamePageProvider extends ChangeNotifier {
  final String difficulty;
  final Dio dio = Dio();
  final int maxQuestions = 10;
  List? questions;
  int currentQuestion = 0;
  int score = 0;
  BuildContext context;
  GamePageProvider({required this.context, required this.difficulty}) {
    dio.options.baseUrl = apiBaseUrl;
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    print(difficulty);
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficulty,
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![currentQuestion]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect = questions![currentQuestion]['correct_answer'] == answer;
    currentQuestion++;
    isCorrect ? score++ : score;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (currentQuestion == maxQuestions) {
      endGame(score);
    } else {
      notifyListeners();
    }
  }

  void endGame(int score) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              'End Game!',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            content: Text(
              'Score: $score/10',
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
    );
  }
}
