import 'dart:async';

import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/dbdata_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/ui/widget/background.dart';
import 'package:appls/ui/widget/griditem.dart';
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
  late Query _todoQuery;
  late List<DbDatosModel> _todoList;
  final presf = SPUsuarios();
  List listimag = [
    "assets/menu/byscar.png",
    "assets/menu/mesimg.png",
    "assets/menu/numerossinfondo.png",
    "assets/menu/byscar.png",
    "assets/menu/ciudades.png",
    "assets/menu/continente.png",
    "assets/menu/config1.png",
    "assets/menu/byscar.png",
    "assets/menu/byscar.png",
  ];
  @override
  void initState() {
    super.initState();
    _todoList = [];
    _todoQuery = _database.reference().child("Categoriastest");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    super.dispose();
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
          return singleMyCourse1(
            title: _todoList[index].nombre!.toUpperCase().replaceAll("-", " ").replaceAll("_", " "),
            image: listimag[index],
            type: "",
            status: "Running",
            lado: false,
            startColor: '#738AE6',
            endColor: '#5C5EDD',
            ontap: () {
              if (presf.audio) {
                AudioLS().speak("${_todoList[index].nombre}");
              }

              Navigator.pushNamed(
                context,
                'GenerarEvaluacionr',
                arguments: DataArguments(
                  nombreac: "${_todoList[index].nombre}".toUpperCase().replaceAll("-", " "),
                  ctg: _todoList[index].nombre!,
                  nodep: 'Categoriastest',
                ),
              );
            },
          );
          //   return Card(
          //     elevation: 2,
          //     borderOnForeground: false,
          //     child: InkWell(
          //       onTap: () {
          //         if (presf.audio) {
          //           AudioLS().speak("${_todoList[index].nombre}");
          //         }

          //         Navigator.pushNamed(
          //           context,
          //           'GenerarEvaluacionr',
          //           arguments: DataArguments(
          //             nombreac: "${_todoList[index].nombre}".toUpperCase().replaceAll("-", " "),
          //             ctg: _todoList[index].nombre!,
          //             nodep: 'Categoriastest',
          //           ),
          //         );
          //       },
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           // SizedBox(
          //           //   width: 100,
          //           //   height: 120,
          //           //   child: Image.asset(
          //           //     "assets/logosenas.png",
          //           //     color: Colors.deepPurple,
          //           //   ),
          //           // ),
          //           Text(
          //             _todoList[index].nombre!.toUpperCase().replaceAll("-", " "),
          //             style: const TextStyle(fontSize: 18),
          //             textScaleFactor: 1.0,
          //             textAlign: TextAlign.center,
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
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
          "Menú Evaluación",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: const [
          // user != null
          //     ?
          // TextButton(
          //   onPressed: () {
          //     Navigator.pushNamed(
          //       context,
          //       'GenerarEvaluacion',
          //     );
          //   },
          //   child: const Text("Generar Quiz"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.pushNamed(
          //       context,
          //       'GenerarEvaluacionr',
          //       arguments: DataArguments(
          //         nombreac: "abecedario",
          //         ctg: "abecedario",
          //         nodep: 'Categorias',
          //       ),
          //     );
          //   },
          //   child: const Text("Generar Quiz r"),
          // )
          // : Container(),
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
