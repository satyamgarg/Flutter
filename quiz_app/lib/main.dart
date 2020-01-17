import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './quiz.dart';
import './result.dart';

void main() => runApp(QuizApplication());

class QuizApplication extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _QuizApplicationState();
  }
}

class _QuizApplicationState extends State<QuizApplication> {

  Future<Post> post;

  @override
  void initState() {
    super.initState();
    //post = fetchPost();
  }


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: roundedButton("No", const Color(0xFF167F67),
                const Color(0xFFFFFFFF)),
          ),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: roundedButton(" Yes ", const Color(0xFF167F67),
                const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    ) ??
        false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }



  //Reference and Value will never get changed
  final _questions = const [
    {
      'questionText':
      '[1/5]. Guess Animal ?',
      'questionImg': 'images/dog.jpg',
      'answers': [
        {'text': 'Sheep', 'score': 0},
        {'text': 'Ziraffe', 'score': 0},
        {'text': 'Dog', 'score': 10},
        {'text': 'Goat', 'score': 0},
      ]
    },
    {
      'questionText': '[2/5]. Guess Animal ?',
      'questionImg': 'images/cow.jpg',
      'answers': [
        {'text': 'Camel', 'score': 0},
        {'text': 'Cow', 'score': 10},
        {'text': 'Elephant', 'score': 0},
        {'text': 'Donkey', 'score': 0},
      ]
    },
    {
      'questionText':
      '[3/5]. Guess Animal ?',
      'questionImg': 'images/tiger.jpg',
      'answers': [
        {'text': 'Cat', 'score': 0},
        {'text': 'Horse', 'score': 0},
        {'text': 'Tiger', 'score': 10},
        {'text': 'Zebra', 'score': 0},
      ]
    },
    {
      'questionText':
      '[4/5]. Guess Animal ?',
      'questionImg': 'images/horse.jpg',
      'answers': [
        {'text': 'Horse', 'score': 10},
        {'text': 'Elaphant', 'score': 0},
        {'text': 'Monkey', 'score': 0},
        {'text': 'Bear', 'score': 0},
      ]
    },
    {
      'questionText':
      '[5/5]. Guess Animal ?',
      'questionImg': 'images/monkey.jpg',
      'answers': [
        {'text': 'Cat', 'score': 0},
        {'text': 'Dog', 'score': 0},
        {'text': 'Lion', 'score': 0},
        {'text': 'Monkey', 'score': 10},
      ]
    },
  ];

  var _index = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _index = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _index += 1;
    });
    print(_index);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(child: MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Post>(
            future: post,
            builder: (context, response) {
              if (response.hasData) {
                return Text("Quiz App"); //response.data.title
              } else if (response.hasError) {
                return Text("Quiz App");
              }else {
                return Text("Quiz App");
              }
              //return CircularProgressIndicator(backgroundColor: Colors.white,);
            },
          ),
        ),
        body: _index < _questions.length
            ? Quiz(
          answerQuestion: _answerQuestion,
          questionIndex: _index,
          questions: _questions,
        )
            : Result(_totalScore, _resetQuiz),
      ),
    ), onWillPop: _onBackPressed);
  }
}


Future<Post> fetchPost() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
