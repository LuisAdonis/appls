import 'package:appls/models/sceen_arg_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/ui/widget/griditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final presf = SPUsuarios();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
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
                  title: "Estudiar",
                  image: 'assets/menu/estdudiarsindondo.png',
                  type: "Las puntas de los dedos tocan dos veces la palma de la mano contraria.",
                  status: "Running",
                  lado: false,
                  startColor: '#738AE6',
                  endColor: '#5C5EDD',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Estudiar");
                    }
                    Navigator.pushNamed(
                      context,
                      'Estudiar',
                      arguments: ScreenArguments(
                        startColor: '#738AE6',
                        endColor: '#5C5EDD',
                      ),
                    );
                  },
                ),
                singleMyCourse1(
                  title: "Diccionario",
                  image: 'assets/menu/diccionariosin.png',
                  type: "La mano se desliza de afuera hacia adentro por la palma de la mano contraria dos veces.",
                  status: "Running",
                  lado: true,
                  startColor: '#FE95B6',
                  endColor: '#FF5287',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Diccionario");
                    }
                    Navigator.pushNamed(
                      context,
                      'Diccionario',
                      arguments: ScreenArguments(
                        startColor: '#FE95B6',
                        endColor: '#FF5287',
                      ),
                    );
                  },
                ),
                singleMyCourse1(
                  title: "Evaluación",
                  image: 'assets/menu/evaluar.png',
                  type: "La mano se desplaza hacia abajo en curva. \nLos ojos siguen la acción",
                  status: "Running",
                  lado: false,
                  startColor: '#6F72CA',
                  endColor: '#1E1466',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Evaluación");
                    }
                    Navigator.pushNamed(
                      context,
                      'Evaluación',
                      arguments: ScreenArguments(
                        startColor: '#6F72CA',
                        endColor: '#1E1466',
                      ),
                    );
                  },
                ),
                singleMyCourse1(
                  title: "Lenguaje ML",
                  image: 'assets/menu/lenguajeseñas.png',
                  type: "Las manos se mueven de adelante hacia atras alternadamente.",
                  status: "Running",
                  lado: true,
                  startColor: '#ea4c57',
                  endColor: '#efae64',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Lenguaje ML");
                    }
                    Navigator.pushNamed(
                      context,
                      'Lenguaje ML',
                      arguments: ScreenArguments(
                        startColor: '#efae64',
                        endColor: '#ea4c57',
                      ),
                    );
                  },
                ),
                singleMyCourse2(
                  title: "Acerca De",
                  image: 'assets/menu/acercade.png',
                  type: "",
                  status: "Running",
                  lado: false,
                  startColor: '#6541bd',
                  endColor: '#5C5EDD',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Acerca De");
                    }
                    Navigator.pushNamed(
                      context,
                      'Acerca De',
                      arguments: ScreenArguments(
                        startColor: '#6541bd',
                        endColor: '#5C5EDD',
                      ),
                    );
                  },
                ),
                singleMyCourse2(
                  title: "Institución",
                  image: 'assets/menu/institutions.png',
                  type: "",
                  status: "Running",
                  lado: true,
                  startColor: '#6541bd',
                  endColor: '#FFB295',
                  ontap: () {
                    if (presf.audio) {
                      AudioLS().speak("Institución");
                    }
                    Navigator.pushNamed(
                      context,
                      'Institución',
                      arguments: ScreenArguments(
                        startColor: '#6541bd',
                        endColor: '#FFB295',
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
