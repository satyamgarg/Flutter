import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;

  final Function resetQuizHandler;

  Result(this.totalScore, this.resetQuizHandler);

  String get resultPhrase {
    var result = 'Your\'s score is $totalScore.\n';
    if (totalScore == 30) {
      result += 'You are awasome!';
    } else if (totalScore == 40) {
      result += 'You are excellent!';
    } else if (totalScore == 50) {
      result += 'You are perfect!';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            color: Colors.green,
            iconSize: 55,
            splashColor: Colors.green,
          ),
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz!'),
            onPressed: resetQuizHandler,
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
