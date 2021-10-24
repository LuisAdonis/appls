import 'dart:math';

import 'package:appls/models/dbdata_model.dart';
import 'package:appls/models/question.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GenerarPregunta extends StatefulWidget {
  const GenerarPregunta({Key? key}) : super(key: key);

  @override
  _GenerarPreguntaState createState() => _GenerarPreguntaState();
}

class _GenerarPreguntaState extends State<GenerarPregunta> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late Query _todoQuery;
  var faker = Faker();
  late List<DbDatosModel> _todoList;
  late List<Question> _todoList1;
  String dropdownvalue = 'abecedario';
  List<String> items = [];
  @override
  void initState() {
    super.initState();
    _todoList = [];
    _todoList1 = [];

    _todoQuery = _database.reference().child("Categorias");
    _todoQuery.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          items.add(key);
        });
      });
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(DbDatosModel.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generar Quiz"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem<String>(value: items, child: Text(items));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
              _todoList.clear();

              _database.reference().child("Categorias/$dropdownvalue").onChildAdded.listen((Event event) {
                setState(() {
                  _todoList.add(DbDatosModel.fromSnapshot(event.snapshot));
                });
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Datos "),
              const Text("Preguntas"),
              OutlinedButton(
                child: const Text("Generar"),
                onPressed: () {
                  List<String> friends = [];
                  Random rnd = Random();
                  int min = 0;
                  int max = _todoList.length;
                  int r = 0;
                  int rf0 = 0;
                  int rf1 = 0;
                  int rf2 = 0;
                  setState(() {
                    r = min + rnd.nextInt(max - min);
                  });
                  setState(() {
                    rf0 = min + rnd.nextInt(max - min);
                  });
                  setState(() {
                    rf1 = min + rnd.nextInt(max - min);
                  });
                  setState(() {
                    rf2 = min + rnd.nextInt(max - min);
                  });
                  // ignore: avoid_print
                  print("$r $rf0 $rf1 $rf2");
                  if (r != rf0 && r != rf1 && r != rf2 && rf0 != rf2 && rf0 != rf1 && rf1 != rf2) {
                    friends.add(_todoList[r].nombre!);
                    friends.add(_todoList[rf0].nombre!);
                    friends.add(_todoList[rf1].nombre!);
                    friends.add(_todoList[rf2].nombre!);
                    friends.reversed;
                    // ignore: avoid_print
                    print("$r $rf0 $rf1 $rf2");
                    // ignore: avoid_print
                    print("$friends");
                    friends.shuffle();
                    // ignore: avoid_print
                    print("$friends");
                    DatabaseReference rootRef = FirebaseDatabase.instance.reference().child("Evaluacion/Categorias/$dropdownvalue");

                    rootRef.push().set({
                      "pregunta": "¿Cual es la respuesta?",
                      "respuestas": friends,
                      "imagen": "${_todoList[r].urldata}",
                      "respuestascorrecta": _todoList[r].nombre,
                    }).whenComplete(() {
                      setState(() {
                        _todoList1.add(Question(
                          id: "ds",
                          imagen: "${_todoList[r].urldata}",
                          pregunta: "${faker.lorem.sentence()}?",
                          categoria: "ss",
                          respuestas: friends,
                          respuestascorrecta: _todoList[r].nombre!,
                        ));
                      });
                      // ignore: avoid_print
                      print(r);
                    });
                  } else {
                    // ignore: avoid_print
                    print("igual");
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _todoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.android),
                        trailing: const Icon(Icons.arrow_right),
                        title: Text("${_todoList[index].nombre}"),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todoList1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Text(_todoList1[index].respuestascorrecta),
                        title: Text(_todoList1[index].respuestascorrecta),
                        subtitle: Text("${_todoList1[index].respuestas}"),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
