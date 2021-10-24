import 'package:appls/const.dart';
import 'package:appls/models/question.dart';
import 'package:appls/models/user_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
  }) : super(key: key);

  final int score;
  final List<Question> questions;
  final int totalTime;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final presf = SPUsuarios();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel?>(context);
    if (presf.audio) {
      AudioLS().speak(
        widget.score >= 3
            ? "Felicidades! Has terminado con ${widget.score} de ${widget.questions.length} respuestas correctas."
            : "Lo sentimos! Has terminado con ${widget.score} de ${widget.questions.length} respuestas correctas.",
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 20,
            child: Container(
              height: size.height / 6,
              width: size.height / 6,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: bubbleColor),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Container(
              height: size.height / 7,
              width: size.height / 7,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: bubbleColor),
            ),
          ),
          Positioned(
            bottom: 234,
            left: 50,
            child: Container(
              height: size.height / 4.5,
              width: size.height / 4.5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: bubbleColor,
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: 0,
            child: Container(
              height: size.height / 5,
              width: size.height / 9,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                  color: bubbleColor),
            ),
          ),
          Positioned(
            top: 230,
            right: 30,
            child: Container(
              height: size.height / 10,
              width: size.height / 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: bubbleColor,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            child: Container(
              height: size.height / 5,
              width: size.height / 5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(130),
                  bottomRight: Radius.circular(80),
                ),
                color: bubbleColor,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(
              top: 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.score >= 3
                    ? Image.asset("assets/trophy.png")
                    : Image.asset(
                        "assets/error.png",
                        width: 150,
                      ),
                Column(children: [
                  Text(
                    widget.score >= 3 ? "Felicidades!" : "Lo sentimos!",
                    // style: AppTextStyles.heading40,
                    style: const TextStyle(
                      fontSize: 40,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Has terminado",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    // style: AppTextStyles.body,
                  ),
                  // Text(
                  //   "Tu calificacion es: ${widget.score * 2}",
                  //   style: const TextStyle(
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   // style: AppTextStyles.bodyBold,
                  // ),
                  Text(
                    "con ${widget.score} de ${widget.questions.length} respuestas correctas.",
                    // "with ${widget.score} out of ${widget.questions.length} right answers.",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    // style: AppTextStyles.body,
                  ),
                ]),
                Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 60),
                    //         child: ElevatedButton(
                    //           child: const Text("Share"),
                    //           onPressed: () {
                    //             // Share.share('I got $rightAnswersCount out of $length right answers on the $title challenge!');
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: ElevatedButton(
                              child: Text(user != null ? "Guardar intento" : "Iniciar sesión"),
                              onPressed: () {
                                if (user != null) {
                                  DatabaseReference rootRef = FirebaseDatabase.instance.reference().child("EvaluacionRes/${user.userId}");
                                  rootRef.push().set({
                                    "id": user.userId,
                                    "categoria": widget.questions[0].categoria,
                                    "preguntascorrectas": widget.score,
                                    "preguntastotal": widget.questions.length,
                                    "fecha": ServerValue.timestamp,
                                    "data": {
                                      "0": widget.questions[0].toJson(),
                                      "1": widget.questions[1].toJson(),
                                      "2": widget.questions[2].toJson(),
                                      "3": widget.questions[3].toJson(),
                                      "4": widget.questions[4].toJson(),
                                    },
                                  }).whenComplete(() {
                                    Navigator.pop(context);
                                    // ignore: avoid_print
                                    print("Termino");
                                  });
                                } else {
                                  // ignore: avoid_print
                                  print("Termino");
                                  Navigator.pushNamed(
                                    context,
                                    'LoginScreen',
                                  );
                                  // Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Scaffold newMethod() {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Result: ${widget.score} / ${widget.questions.length}',
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
