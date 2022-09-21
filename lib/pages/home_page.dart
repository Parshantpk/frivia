import 'package:flutter/material.dart';
import 'package:frivia/constants.dart';
import 'package:frivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;

  String difficulty = 'Easy';

  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              appTile(),
              difficultySlider(),
              startButton(context, difficulty),
            ],
          ),
        ),
      ),
    );
  }

  Widget appTile(){
    return Column(
      children: [
        const Text(
          'Frivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          difficulty,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
  Widget startButton(BuildContext context, String difficulty) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(difficulty: difficulty.toLowerCase()),
          ),
        );
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        'Start',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget difficultySlider() {
    return Slider(
      value: _value,
      min: 0.0,
      max: 2.0,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      divisions: 2,
      label: 'Difficulty',
      onChangeStart: (double value) {
        value.toString();
      },
      onChangeEnd: (double value) {
        if (value.toString() == '0.0') {
          difficulty = 'Easy';
        }
        if (value.toString() == '1.0') {
          difficulty = 'Medium';
        }
        if (value.toString() == '2.0') {
          difficulty = 'Hard';
        }
        setState(() {});
      },
    );
  }
}
