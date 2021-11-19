import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/libro_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LibreriaDisponible extends StatefulWidget {
  const LibreriaDisponible({Key? key, required this.arguments}) : super(key: key);
  final DataArguments arguments;
  @override
  _LibreriaDisponibleState createState() => _LibreriaDisponibleState();
}

class _LibreriaDisponibleState extends State<LibreriaDisponible> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late Query _todoQuery;
  late List<LibroModel> _libros;
  final presf = SPUsuarios();
  @override
  void initState() {
    super.initState();

    _libros = [];
    _todoQuery = _database.reference().child("AudiosLibros");
    _todoQuery.onChildAdded.listen(onEntryAdded);
  }

  onEntryAdded(Event event) {
    if (mounted) {
      setState(() {
        _libros.add(LibroModel.fromSnapshot(event.snapshot));
      });
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
          "Audios Libros Disponibles ${_libros.length}",
          style: const TextStyle(color: Colors.black),
        ),
        actions: const [
          // IconButton(
          //   onPressed: () => adddata(),
          //   icon: Icon(Icons.save),
          // )
        ],
      ),
      body: ListView.builder(
        itemCount: _libros.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 140.0,
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (presf.audio) {
                      AudioLS().speak(_libros[index].nombrelibro);
                    }
                    Navigator.pushNamed(
                      context,
                      'ReproductorAudio',
                      arguments: DataArguments1(
                        nombreac: 'Audios Libros',
                        ctg: "AudiosLibros",
                        nodep: _libros[index],
                      ),
                    );
                  },
                  child: Container(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(50.0, 16.0, 16.0, 16.0),
                      constraints: const BoxConstraints.expand(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 4.0),
                          Text(
                            _libros[index].nombrelibro,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Container(height: 10.0),
                          Text(
                            "Autor: ${_libros[index].autor}",
                            style: const TextStyle(
                              color: Color(0xffb6b2df),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            height: 2.0,
                            width: 18.0,
                            // color: const Color(0xff00c6ff),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.timelapse,
                                      color: Colors.grey,
                                    ),
                                    Container(width: 8.0),
                                    const Text(
                                      "Duracion: ",
                                      style: TextStyle(
                                        color: Color(0xffb6b2df),
                                        fontSize: 9.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      " ${_libros[index].tiempor}",
                                      style: const TextStyle(
                                        color: Color(0xffb6b2df),
                                        fontSize: 9.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.list,
                                      color: Colors.grey,
                                    ),
                                    Container(width: 8.0),
                                    Text(
                                      "Capitulos: ${_libros[index].capitulos}",
                                      style: const TextStyle(
                                        color: Color(0xffb6b2df),
                                        fontSize: 9.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    height: 124,
                    margin: const EdgeInsets.only(left: 46),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333366),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 40,
                    top: 20,
                  ),
                  alignment: FractionalOffset.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: _libros[index].imgUrl,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
