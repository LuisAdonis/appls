import 'dart:async';
import 'dart:math';

import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/dbdata_model.dart';
import 'package:appls/models/question.dart';
import 'package:appls/models/result_arguments_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GenerarPreguntar extends StatefulWidget {
  final DataArguments arguments;
  const GenerarPreguntar({Key? key, required this.arguments}) : super(key: key);

  @override
  _GenerarPreguntarState createState() => _GenerarPreguntarState();
}

class _GenerarPreguntarState extends State<GenerarPreguntar> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  // ignore: unused_field
  late StreamSubscription<Event> _onTodoAddedSubscription;
  late Query _todoQuery;
  List<Question> questions = [];
  late List<DbDatosModel> _todoList;
  late List<Question> _todoList1;

  final presf = SPUsuarios();

  int _currentIndex = 0;
  String _selectedAnswer = '';
  int _score = 0;

  late Timer _timer;

  int _currentTime = 1;

  @override
  void initState() {
    super.initState();
    _todoList = [];
    _todoList1 = [];
    _todoQuery = _database.reference().child(widget.arguments.nodep).child(widget.arguments.ctg!);
    // ignore: avoid_print
    print("${widget.arguments.ctg} ${widget.arguments.nombreac} ${widget.arguments.nodep}");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // ignore: avoid_print
      print(_currentTime);
      setState(() {
        _currentTime -= 1;
      });

      if (_currentTime == 0) {
        _timer.cancel();
        // pushResultScreen(context);
        for (var i = 0; i < 5; i++) {
          fn();
        }
      }
    });
  }

  onEntryAdded(Event event) async {
    setState(() {
      _todoList.add(DbDatosModel.fromSnapshot(event.snapshot));
    });
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      'Resultado',
      arguments: ResultArguments(
        questions: _todoList1,
        totalTime: 20,
        score: _score,
      ),
    );
    // ignore: avoid_print
    print("object");
  }

  fn() {
    _todoList1.clear();
    List<String> friends = [];
    Random rnd = Random();
    int min = 0;
    int max = _todoList.length;
    int r = 0;
    int rf0 = 0;
    int rf1 = 0;
    int rf2 = 0;
    r = min + rnd.nextInt(max - min);
    rf2 = min + rnd.nextInt(max - min);
    rf0 = min + rnd.nextInt(max - min);
    rf1 = min + rnd.nextInt(max - min);

    // ignore: avoid_print
    if (r != rf0 && r != rf1 && r != rf2 && rf0 != rf2 && rf0 != rf1 && rf1 != rf2) {
      friends.add(_todoList[r].nombre!);
      friends.add(_todoList[rf0].nombre!);
      friends.add(_todoList[rf1].nombre!);
      friends.add(_todoList[rf2].nombre!);
      friends.shuffle();

      // ignore: avoid_print
      DatabaseReference rootRef = FirebaseDatabase.instance.reference().child("Evaluacion/Categorias/${widget.arguments.ctg}");

      rootRef.set({
        "pregunta": "¿Cual es la respuesta?",
        "respuestas": friends,
        "imagen": "${_todoList[r].urldata}",
        "respuestascorrecta": _todoList[r].nombre,
      }).whenComplete(() {
        setState(() {
          _todoList1.add(Question(
            id: "ds",
            imagen: "${_todoList[r].urldata}",
            pregunta: "¿Que significa la imagen?",
            respuestas: friends,
            categoria: widget.arguments.ctg!,
            respuestascorrecta: _todoList[r].nombre!,
          ));
        });
        // ignore: avoid_print
        print("1:  $r");
      });
    } else {
      // ignore: avoid_print
      print("igual");
      fn();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_todoList1.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final Question currentQuestion = _todoList1[_currentIndex];
      if (presf.audio) {
        AudioLS().speak("${currentQuestion.pregunta} ");
      }
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

                          Future.delayed(const Duration(milliseconds: 1000), () {
                            if (_currentIndex == _todoList1.length - 1) {
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
                            : const Text(""),
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
}
