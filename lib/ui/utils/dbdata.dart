import 'dart:async';

import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/dbdata_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/ui/widget/herophotoview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DBData extends StatefulWidget {
  final DataArguments arguments;

  const DBData({Key? key, required this.arguments}) : super(key: key);

  @override
  _DBDataState createState() => _DBDataState();
}

class _DBDataState extends State<DBData> {
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
    _todoQuery = _database.reference().child(widget.arguments.nodep).child(widget.arguments.ctg!);
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
      _todoList.add(DbDatosModel.fromSnapshot(event.snapshot));
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroPhotoViewRouteWrapper(
                      name: _todoList[index].nombre,
                      imageProvider: CachedNetworkImageProvider(
                        _todoList[index].urldata!,
                      ),
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CachedNetworkImage(
                    imageUrl: _todoList[index].urldata!,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Text(
                    _todoList[index].nombre!,
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
