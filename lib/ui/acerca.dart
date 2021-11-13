import 'package:appls/ui/utils/hexcolor.dart';
import 'package:appls/ui/widget/griditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({Key? key}) : super(key: key);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "UNIVERSIDAD LAICA ELOY ALFARO DE MANABÍ\nDIRECCIÓN DE POSGRADO, COOPERACIÓN Y RELACIONES \nINTERNACIONALES\n",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Tema:",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Herramienta para la comunicación de lengua de señas con Deep Learning en la Unidad Educativa Juan Montalvo",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                // color: Colors.teal,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 250,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/yo.jpeg'),
                          ),
                        ),
                        Text(
                          'Ing. Pedro Anchundia Delgado',
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          'Desarrollador.',
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                // color: Colors.teal,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 250,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/tutor.jpeg'),
                          ),
                        ),
                        Text(
                          'Ing. Jorge Pincay Ponce, PhD',
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          'Tutor',
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container newMethod() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 220,
                        width: 160,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/yo.jpeg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.teal,
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Ing. Pedro Anchundia Delgado",
                              style: TextStyle(fontSize: 20),
                            ),
                            const Text(
                              "Desarrollador",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const <Widget>[
                                Icon(
                                  Icons.email,
                                  color: Color(0xffefae64),
                                ),
                                Icon(
                                  Icons.call,
                                  color: Color(0xff738AE6),
                                ),
                                Icon(
                                  Icons.video_call,
                                  color: Color(0xff6F72CA),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     "Acerca de.",
                //     style: TextStyle(fontSize: 22),
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     "Dr. Stefeni Albert is a cardiologist in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                //     textAlign: TextAlign.justify,
                //     style: TextStyle(color: Colors.grey, fontSize: 16),
                //   ),
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 220,
                      width: 160,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/tutor.jpeg",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.teal,
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Ing. Jorge Pincay Ponce.",
                              style: TextStyle(fontSize: 20),
                            ),
                            const Text(
                              "PhD.",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            const Text(
                              "Tutor",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const <Widget>[
                                Icon(
                                  Icons.email,
                                  color: Color(0xffefae64),
                                ),
                                Icon(
                                  Icons.call,
                                  color: Color(0xff738AE6),
                                ),
                                Icon(
                                  Icons.video_call,
                                  color: Color(0xff6F72CA),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     "Acerca De.",
                //     style: TextStyle(fontSize: 22),
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     "Dr. Stefeni Albert is a cardiologist in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                //     textAlign: TextAlign.justify,
                //     style: TextStyle(color: Colors.grey, fontSize: 16),
                //   ),
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
