import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizAppState();
  }
}

class _QuizAppState extends State<QuizApp> {
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
          title: Text('Quiz App'),
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
