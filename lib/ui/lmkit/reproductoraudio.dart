import 'dart:async';

import 'package:appls/models/chapter_model.dart';
import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/ui/utils/basescafflod.dart';
import 'package:appls/ui/utils/tracklite.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReproductorAudios extends StatefulWidget {
  final DataArguments1 arguments;
  const ReproductorAudios({Key? key, required this.arguments}) : super(key: key);

  @override
  _ReproductorAudiosState createState() => _ReproductorAudiosState();
}

class _ReproductorAudiosState extends State<ReproductorAudios> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late Query _todoQuery;
  late List<Chapter> _todoList;
  late StreamSubscription<Event> _onTodoAddedSubscription;
  late StreamSubscription<Event> _onTodoChangedSubscription;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _todoList = [];
    _todoQuery = _database.reference().child("AudiosLibros").child(widget.arguments.nodep.id).child("chapter");
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  onEntryAdded(Event event) {
    if (mounted) {
      setState(() {
        _todoList.add(Chapter.fromSnapshot(event.snapshot));
      });
    }
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      // ignore: unrelated_type_equality_checks
      return entry.cap == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] = Chapter.fromSnapshot(event.snapshot);
    });
  }

  adddata() {
    var d = _database.reference().child("AudiosLibros").push().key;
    var data = {
      "capitulos": "21",
      "capitulospartes": {
        "1": "2a",
        "2": "2sa",
        "3": "2aa",
      },
      "id": d,
      "descripcion": "dad ad adsadfdgfdgs fgdsgf asfdgsfdg ",
      "imagen": "afd",
      "nombre": "asafd asfda",
      "url": "aasdasdd",
    };
    _database.reference().child("AudiosLibros").child(d).set(data).whenComplete(() {
      // ignore: avoid_print
      print("object");
    });
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
          widget.arguments.nodep.nombrelibro,
          style: const TextStyle(color: Colors.black),
        ),
        actions: const [
          // IconButton(
          //   onPressed: () => adddata(),
          //   icon: Icon(Icons.save),
          // )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _todoList.isNotEmpty
            ? BaseScaffold(
                isLoaded: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: _todoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TrackTile(
                              track: _todoList[index],
                              index: index,
                              capi: widget.arguments.nodep,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ),
      ),
    );
  }

  // SingleChildScrollView newMethod() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         ListView.builder(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           itemCount: _todoList.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: const EdgeInsets.only(top: 5, bottom: 5),
  //               child: Card(
  //                 color: Color(0xff738AE6),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                 ),
  //                 elevation: 0,
  //                 child: InkWell(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   splashColor: const Color(0xff311B92),
  //                   hoverColor: const Color(0xff311B92),
  //                   focusColor: const Color(0xff311B92),
  //                   highlightColor: const Color(0xff311B92),
  //                   onTap: () {},
  //                   child: Column(
  //                     children: [
  //                       ListTile(
  //                         leading: Image.network(_todoList[index].imagen),
  //                         title: Text(
  //                           _todoList[index].nombre,
  //                           style: const TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           _todoList[index].descripcion,
  //                           style: const TextStyle(color: Colors.white),
  //                         ),
  //                         trailing: IconButton(
  //                           icon: const Icon(Icons.play_arrow),
  //                           onPressed: () {
  //                             Navigator.pushNamed(
  //                               context,
  //                               'ReproductorAudio',
  //                               arguments: DataArguments(
  //                                 nombreac: 'Abecedario',
  //                                 ctg: _todoList[index].id,
  //                                 nodep: 'Categorias',
  //                               ),
  //                             );
  //                           },
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
