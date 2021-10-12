import 'dart:async';
import 'dart:math';

import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/dbdata_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:faker/faker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EvaluacionScreen extends StatefulWidget {
  const EvaluacionScreen({Key? key}) : super(key: key);

  @override
  _EvaluacionScreenState createState() => _EvaluacionScreenState();
}

class _EvaluacionScreenState extends State<EvaluacionScreen> {
  var faker = Faker();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late StreamSubscription<Event> _onTodoAddedSubscription;
  late StreamSubscription<Event> _onTodoChangedSubscription;
  late Query _todoQuery;
  late List<DbDatosModel> _todoList;
  final presf = SPUsuarios();
  @override
  void initState() {
    super.initState();
    _todoList = [];
    _todoQuery = _database.reference().child("Evaluacion/Categorias");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] = DbDatosModel.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(DbDatosModel(nombre: event.snapshot.key, imagen: null, nombrearchivo: null, urldata: null, video: null));
    });
  }

  Widget showTodoList() {
    if (_todoList.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: _todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2,
            borderOnForeground: false,
            child: InkWell(
              onTap: () {
                if (presf.audio) {
                  AudioLS().speak("${_todoList[index].nombre}");
                }

                Navigator.pushNamed(
                  context,
                  'QuizScreen',
                  arguments: DataArguments(
                    nombreac: "${_todoList[index].nombre}".toUpperCase().replaceAll("-", " "),
                    ctg: _todoList[index].nombre!,
                    nodep: 'Evaluacion/Categorias',
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    height: 120,
                    child: Image.asset("assets/logosenas.png"),
                  ),
                  Text(
                    _todoList[index].nombre!.toUpperCase().replaceAll("-", " "),
                    style: const TextStyle(fontSize: 20),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          "Menu Evaluación",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              DatabaseReference rootRef = FirebaseDatabase.instance.reference().child("Evaluacion/Categorias/abecedario");
              List<String> friends = [];
              friends.add(faker.person.name());
              friends.add(faker.person.name());
              friends.add(faker.person.name());
              friends.add(faker.person.name());
              Random rnd = Random();
              int min = 0;
              int max = 4;
              int r = 0;
              setState(() {
                r = min + rnd.nextInt(max - min);
              });
              rootRef.push().set({
                "pregunta": "${faker.lorem.sentence()}?",
                "respuestas": friends,
                "imagen": "",
                "respuestascorrecta": friends[r],
              }).whenComplete(() => print(r));
            },
            child: const Text("Generar Random"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: showTodoList(),
        ),
      ),
    );
  }
}
