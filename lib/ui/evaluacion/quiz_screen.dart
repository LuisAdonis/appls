import 'dart:async';

import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/question.dart';
import 'package:appls/models/result_arguments_model.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final DataArguments arguments;
  const QuizScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late StreamSubscription<Event> _onTodoAddedSubscription;
  late StreamSubscription<Event> _onTodoChangedSubscription;
  late Query _todoQuery;
  List<Question> questions = [];
  final presf = SPUsuarios();

  int _currentIndex = 0;
  String _selectedAnswer = '';
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _todoQuery = _database.reference().child(widget.arguments.nodep).child(widget.arguments.ctg!);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(onEntryChanged);
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   // ignore: avoid_print
    //   print(_currentTime);
    //   setState(() {
    //     _currentTime -= 1;
    //   });

    //   if (_currentTime == 0) {
    //     _timer.cancel();
    //     // pushResultScreen(context);
    //   }
    // });
  }

  onEntryChanged(Event event) {
    var oldEntry = questions.singleWhere((entry) {
      return entry.id == event.snapshot.key;
    });

    setState(() {
      questions[questions.indexOf(oldEntry)] = Question.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      questions.add(Question.fromSnapshot(event.snapshot));
    });
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      'Resultado',
      arguments: ResultArguments(
        questions: questions,
        totalTime: 20,
        score: _score,
      ),
    );
    // ignore: avoid_print
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = questions[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evaluacíon"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // const Text(
          //   'Pregunta?',
          //   style: TextStyle(
          //     fontSize: 20,
          //     color: Colors.black,
          //   ),
          // ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              currentQuestion.pregunta,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          widget.arguments.ctg == 'abecedario'
              ? CachedNetworkImage(
                  imageUrl: currentQuestion.imagen,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : AspectRatio(
                  aspectRatio: 1.5,
                  child: CachedNetworkImage(
                    imageUrl: currentQuestion.imagen,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final answer = currentQuestion.respuestas[index];
                  return Card(
                    color: answer == _selectedAnswer ? Colors.grey.withOpacity(0.1) : Colors.white,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _selectedAnswer = answer;
                        });
                        if (answer == currentQuestion.respuestascorrecta) {
                          _score++;
                        }

                        Future.delayed(const Duration(milliseconds: 2000), () {
                          if (_currentIndex == questions.length - 1) {
                            pushResultScreen(context);
                            return;
                          }
                          setState(() {
                            _currentIndex++;
                            _selectedAnswer = '';
                          });
                        });
                      },
                      trailing: _selectedAnswer != ""
                          ? answer == currentQuestion.respuestascorrecta
                              ? const Icon(Icons.check_circle, color: Colors.teal)
                              : const Icon(Icons.close, color: Colors.red)
                          : Text(""),
                      title: Text(
                        "$answer  ",
                        style: TextStyle(
                          fontSize: 18,
                          color: answer == _selectedAnswer ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: currentQuestion.respuestas.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
