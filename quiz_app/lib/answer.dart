import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: EdgeInsets.all(2),
      child: RaisedButton(
        color: Colors.blue,
        child: Text(answerText),
        onPressed: selectHandler,
        textColor: Colors.white,
      ),
    );
  }
}
