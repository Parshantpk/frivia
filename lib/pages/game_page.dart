import 'package:flutter/material.dart';
import 'package:frivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  String difficulty;
  GamePage({Key? key, required this.difficulty}) : super(key: key);

  GamePageProvider? _gamePageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context, difficulty: difficulty),
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(builder: (context) {
      _gamePageProvider = context.watch<GamePageProvider>();
      if (_gamePageProvider!.questions != null) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
            child: gameUI(),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(height: _deviceHeight! * 0.01),
            falseButton(),
          ],
        ),
      ],
    );
  }

  Widget questionText() {
    return Text(
      _gamePageProvider!.getCurrentQuestionText(),
      style: kQuestionTextStyle(),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {
        _gamePageProvider!.answerQuestion('True');
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        'True',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {
        _gamePageProvider!.answerQuestion('False');
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        'False',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
