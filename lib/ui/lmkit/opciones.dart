import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/sceen_arg_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/service/audios.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/ui/widget/griditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpcvionesF extends StatefulWidget {
  const OpcvionesF({Key? key}) : super(key: key);
  @override
  _OpcvionesFState createState() => _OpcvionesFState();
}

class _OpcvionesFState extends State<OpcvionesF> {
  bool fetchingSongs = false;
  final presf = SPUsuarios();
  @override
  void initState() {
    search();
    super.initState();
  }

  search() async {
    String searchQuery = "a";
    if (searchQuery.isEmpty) return;
    fetchingSongs = true;
    setState(() {});
    await fetchSongsList(searchQuery);
    fetchingSongs = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(4),
              crossAxisSpacing: 8,
              childAspectRatio: 0.8,
              children: <Widget>[
                singleMyCourse1(
                  title: "Detector de Leguajes de señas",
                  image: 'assets/menu/lenguajeseñas.png',
                  type: "Las manos se mueven de adelante hacia atras alternadamente.",
                  status: "Running",
                  lado: true,
                  startColor: '#ea4c57',
                  endColor: '#efae64',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Detector de Leguajes de señas");
                    }
                    Navigator.pushNamed(
                      context,
                      'LenguajeCamara',
                      arguments: ScreenArguments(
                        startColor: '#efae64',
                        endColor: '#ea4c57',
                      ),
                    );
                  },
                ),
                singleMyCourse2(
                  title: "Audio Libros",
                  image: 'assets/menu/audiolibrop.png',
                  type: "Las manos se mueven de adelante hacia atras alternadamente.",
                  status: "Running",
                  lado: true,
                  startColor: '#ea4c57',
                  endColor: '#efae64',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Audio Libros");
                    }
                    Navigator.pushNamed(
                      context,
                      'Libreria',
                      arguments: DataArguments(
                        nombreac: 'Audios Libros',
                        ctg: "AudiosLibros",
                        nodep: 'AudiosLibros',
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
