import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'questionbrain.dart';

Questionbrain qb = Questionbrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Icon goodAnswer = const Icon(
    Icons.check,
    color: Colors.green,
  );

  Icon badAnswer = const Icon(
    Icons.close,
    color: Colors.red,
  );

  List<Widget> score = [];

  void checkAnswer(bool userA) {
    bool correctA = qb.questionAnswer();
    setState(() {
      if (qb.isFinished()) {
        Alert(
          context: context,
          title: "Quiz Finished",
          desc: "You\'ve reached the end of the quiz.",
        ).show();
        qb.reset();
        score = [];
      } else {
        if (userA == correctA) {
          score.add(goodAnswer);
        } else {
          score.add(badAnswer);
        }
        qb.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.questionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
              ),
              child: const Text(
                'True',
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
              ),
              child: const Text(
                'False',
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
