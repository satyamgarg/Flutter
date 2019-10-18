import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './quiz.dart';
import './result.dart';

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

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _QuizAppState();
  }
}

class _QuizAppState extends State<QuizApp> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  //Reference and Value will never get changed
  final _questions = const [
    {
      'questionText':
          '[1/5]. The language spoken by the people by Pakistan is ?',
      'answers': [
        {'text': 'Hindi', 'score': 0},
        {'text': 'Palauan', 'score': 0},
        {'text': 'Sindhi', 'score': 10},
        {'text': 'Nauruan', 'score': 0},
      ]
    },
    {
      'questionText': '[2/5]. The World Largest desert is ?',
      'answers': [
        {'text': 'Thar', 'score': 0},
        {'text': 'Sahara', 'score': 10},
        {'text': 'Kalahari', 'score': 0},
        {'text': 'Sonoran', 'score': 0},
      ]
    },
    {
      'questionText':
          '[3/5]. Country that has the highest in Barley Production ?',
      'answers': [
        {'text': 'China', 'score': 0},
        {'text': 'India', 'score': 0},
        {'text': 'Russia', 'score': 10},
        {'text': 'France', 'score': 0},
      ]
    },
    {
      'questionText':
          '[4/5]. The metal whose salts are sensitive to light is ?',
      'answers': [
        {'text': 'Silver', 'score': 10},
        {'text': 'Zinc', 'score': 0},
        {'text': 'Copper', 'score': 0},
        {'text': 'Aluminium', 'score': 0},
      ]
    },
    {
      'questionText':
          '[5/5]. The Central Rice Research Station is situated in ?',
      'answers': [
        {'text': 'Chennai', 'score': 0},
        {'text': 'Bangalore', 'score': 0},
        {'text': 'Quilon', 'score': 0},
        {'text': 'Cuttack', 'score': 10},
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data.title);
              } else if(snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
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
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
