import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InstitucionScreen extends StatefulWidget {
  const InstitucionScreen({Key? key}) : super(key: key);

  @override
  State<InstitucionScreen> createState() => _InstitucionScreenState();
}

class _InstitucionScreenState extends State<InstitucionScreen> {
  final presf = SPUsuarios();
  @override
  Widget build(BuildContext context) {
    if (presf.audio) {
      AudioLS().speak("UNIDAD EDUCATIVA FIS COMISIONAL “JUAN MONTALVO” DRA. EDELMARY MUÑOZ AVEIGA MG rectora");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    "assets/logosjm.png",
                    width: MediaQuery.of(context).size.width * 0.40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "UNIDAD EDUCATIVA FISCOMISIONAL “JUAN MONTALVO”",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          "DRA. EDELMARY MUÑOZ AVEIGA",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          "MG rectora",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        //   Row(
                        //     children: const <Widget>[
                        //       IconTile(
                        //         backColor: Color(0xffFFECDD),
                        //         imgAssetPath: "assets/email.png",
                        //       ),
                        //       IconTile(
                        //         backColor: Color(0xffFEF2F0),
                        //         imgAssetPath: "assets/call.png",
                        //       ),
                        //       IconTile(
                        //         backColor: Color(0xffEBECEF),
                        //         imgAssetPath: "assets/video_call.png",
                        //       ),
                        //     ],
                        //   )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Acerca de.",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "MISIÓN",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Formar ciudadanos de pensamiento crítico, capaces de participar de manera activa de la sociedad del conocimiento, con mentalidad internacional y gestores de la cultura del dialogo y la paz en un mundo diverso y multicultural. ",
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "VISIÓN",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Ser una institución educativa integral, inclusiva con visión de mundo que promueve el emprendimiento la innovación educativa y la gestión del aprendizaje significativo para formar jóvenes con una profunda sensibilidad social y humana al servicio de la comunidad y el buen vivir.",
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset("assets/mappin.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Dirección",
                                style: TextStyle(color: Colors.black87.withOpacity(0.7), fontSize: 20),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 268,
                                  child: const Text(
                                    "Avenida Universidad 5, Manta",
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset("assets/clock.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Horario",
                                style: TextStyle(color: Colors.black87.withOpacity(0.7), fontSize: 20),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 268,
                                  child: const Text(
                                    '''Lunes - Viernes
abierto hasta las 7 Pm''',
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/map1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
