import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(QuizzlerScreen());

QuizBrain quizBrain = QuizBrain();

class QuizzlerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: QuizApp()),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> _scoreKeeper = [];
  int _rightAnswers = 0;

  void checkAnswer(bool userPickedAnswer) {
    if (!quizBrain.isFinished()) {
      bool correctAnswer = quizBrain.getQuestionAnswer();

      if (userPickedAnswer == correctAnswer) {
        _scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        _rightAnswers++;
      } else
        _scoreKeeper.add(Icon(Icons.close, color: Colors.red));

      quizBrain.nextQuestion();
    } else {
      Alert(
        context: context,
        type: AlertType.success,
        title: 'CONGRATULATIONS!',
        desc:
            'You\'ve reached the end of the Quiz and got $_rightAnswers answers right',
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      quizBrain.resetQuestions();
      _scoreKeeper.clear();
      _rightAnswers = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton(
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                });
              },
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton(
              child: Text(
                'FALSE',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                });
              },
              color: Colors.red,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: _scoreKeeper),
          ),
        )
      ],
    );
  }
}
