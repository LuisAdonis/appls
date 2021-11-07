import 'dart:async';

import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/dbdata_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/ui/widget/griditem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DBDataCategoria extends StatefulWidget {
  final DataArguments arguments;
  const DBDataCategoria({Key? key, required this.arguments}) : super(key: key);

  @override
  _DBDataCategoriaState createState() => _DBDataCategoriaState();
}

class _DBDataCategoriaState extends State<DBDataCategoria> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late StreamSubscription<Event> _onTodoAddedSubscription;
  late StreamSubscription<Event> _onTodoChangedSubscription;
  late Query _todoQuery;
  late List<DbDatosModel> _todoList;
  final presf = SPUsuarios();
  List listimag = [
    "assets/menu/abecedarioaslsinfondo.png",
    "assets/menu/byscar.png",
    "assets/menu/personasorda.png",
    "assets/menu/ciudades.png",
    "assets/menu/config1.png",
    "assets/menu/continente.png",
    "assets/menu/calendariosdl.png",
    "assets/menu/byscar.png",
    "assets/menu/mesimg.png",
    "assets/menu/numerossinfondo.png",
    "assets/menu/byscar.png",
    "assets/menu/byscar.png",
    "assets/menu/byscar.png",
    "assets/menu/byscar.png",
    "assets/menu/byscar.png",
  ];
  @override
  void initState() {
    super.initState();
    _todoList = [];
    _todoQuery = _database.reference().child(widget.arguments.nodep);
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
                'DBData',
                arguments: DataArguments(
                  nombreac: "${_todoList[index].nombre}".toUpperCase().replaceAll("-", " "),
                  ctg: _todoList[index].nombre!,
                  nodep: 'Categorias',
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
          //           'DBData',
          //           arguments: DataArguments(
          //             nombreac: "${_todoList[index].nombre}".toUpperCase().replaceAll("-", " "),
          //             ctg: _todoList[index].nombre!,
          //             nodep: 'Categorias',
          //           ),
          //         );
          //       },
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           SizedBox(
          //             width: 100,
          //             height: 120,
          //             child: Image.asset(listimag[index]),
          //           ),
          //           Text(
          //             _todoList[index].nombre!.toUpperCase().replaceAll("-", " "),
          //             style: const TextStyle(fontSize: 18),
          //             textScaleFactor: 1.0,
          //           ),
          //           // Text(
          //           //   "a${_todoList[index].imagen}",
          //           //   style: const TextStyle(fontSize: 20),
          //           //   textScaleFactor: 1.0,
          //           // ),
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
        centerTitle: true,
        title: Text(
          "${widget.arguments.nombreac}",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: showTodoList(),
        ),
      ),
    );
  }
}
