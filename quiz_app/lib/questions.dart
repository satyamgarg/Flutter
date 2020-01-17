import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;
  final String questionImage;

  Question(this.question, this.questionImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        children: <Widget>[
          Text(
            question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            textAlign: TextAlign.start,
          ),
          Image.asset(
            questionImage,
            width: 250,
            height: 250,
          ),
        ],
      ),
    );
  }
}
