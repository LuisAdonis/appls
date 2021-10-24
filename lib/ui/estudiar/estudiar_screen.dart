import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/ui/widget/griditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EstudiarScreen extends StatefulWidget {
  const EstudiarScreen({Key? key}) : super(key: key);

  @override
  _EstudiarScreenState createState() => _EstudiarScreenState();
}

class _EstudiarScreenState extends State<EstudiarScreen> {
  final presf = SPUsuarios();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          'Menu Estudiar',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                  title: "Abecedario",
                  image: 'assets/menu/abecedarioaslsinfondo.png',
                  type: "Las manos ser abre y se desplaza hacia afuera, mientras los dedosse mueven alternadamente.",
                  status: "Running",
                  lado: false,
                  startColor: '#738AE6',
                  endColor: '#5C5EDD',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Abecedario");
                    }
                    Navigator.pushNamed(
                      context,
                      'DBData',
                      arguments: DataArguments(
                        nombreac: 'Abecedario',
                        ctg: 'abecedario',
                        nodep: 'Categorias',
                      ),
                    );
                  },
                ),
                singleMyCourse1(
                  title: "Números",
                  image: 'assets/menu/numerossinfondo.png',
                  type: "Las manos unidas se mueven de adelante hacia atrás alternadamente. La boca está cerrada con los labios hacia afuera.",
                  status: "Running",
                  lado: false,
                  startColor: '#738AE6',
                  endColor: '#5C5EDD',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Números");
                    }
                    Navigator.pushNamed(
                      context,
                      'DBData',
                      arguments: DataArguments(
                        nombreac: 'Números',
                        ctg: 'numeros',
                        nodep: 'Categorias',
                      ),
                    );
                  },
                ),
                singleMyCourse1(
                  title: "Calendario",
                  image: 'assets/menu/calendariosdl.png',
                  type: "La mano de arriba se separa en curva hacia adelante.",
                  status: "Running",
                  lado: false,
                  startColor: '#738AE6',
                  endColor: '#5C5EDD',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Calendario");
                    }
                    Navigator.pushNamed(
                      context,
                      'DBData',
                      arguments: DataArguments(
                        nombreac: 'Calendario',
                        ctg: 'meses-del-ano',
                        nodep: 'Categorias',
                      ),
                    );
                  },
                ),
                singleMyCourse1(
                  title: "Aprendizaje",
                  image: 'assets/menu/aprendersinfondo.png',
                  type: "La mano se separa de la palma de la mano contraria, sube mientras se cierrá y toca la frente. La boca está cerrada con los labios hacia afuera.",
                  status: "Running",
                  lado: false,
                  startColor: '#738AE6',
                  endColor: '#5C5EDD',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Aprendizaje");
                    }
                    Navigator.pushNamed(
                      context,
                      'DBDatac',
                      arguments: DataArguments(
                        nombreac: 'Aprendizaje',
                        ctg: 'dias-de-la-semana',
                        nodep: 'Categorias',
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
