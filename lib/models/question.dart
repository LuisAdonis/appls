import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Question {
  Question({
    required this.id,
    required this.pregunta,
    required this.imagen,
    required this.respuestas,
    required this.respuestascorrecta,
  });
  final String id;
  final String pregunta;
  final List<String> respuestas;
  final String respuestascorrecta;
  final String imagen;

  Question.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        pregunta = snapshot.value["pregunta"],
        respuestas = List.from(snapshot.value["respuestas"]),
        respuestascorrecta = snapshot.value["respuestascorrecta"],
        imagen = snapshot.value["imagen"];

  toJson() {
    return {
      "pregunta": pregunta,
      "respuestas": respuestas,
      "respuestascorrecta": respuestascorrecta,
      "imagen": imagen,
    };
  }

  @override
  String toString() {
    return 'Question(id: $id, pregunta: $pregunta, respuestas: $respuestas, respuestascorrecta: $respuestascorrecta,imagen:$imagen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question && other.id == id && other.pregunta == pregunta && listEquals(other.respuestas, respuestas) && other.respuestascorrecta == respuestascorrecta;
  }

  @override
  int get hashCode {
    return id.hashCode ^ pregunta.hashCode ^ respuestas.hashCode ^ respuestascorrecta.hashCode;
  }
}

// List<Question> question = [
//   Question(
//     id: '1',
//     question: 'विश्व सम्पदा सूचीमा नेपाल को कति सम्पदा सुचित छन् ?',
//     answers: ['६', '७', '१०', '१४'],
//     correctAnswer: '१०',
//   ),
//   Question(
//     id: '2',
//     question: 'प्रहरी र जेल नभएको देश कुन हो ?',
//     answers: ['भारत', 'जर्मनी', 'फ्रान्स', 'आइसल्याण्ड'],
//     correctAnswer: 'आइसल्याण्ड',
//   ),
//   Question(
//     id: '3',
//     question: 'नेपालमा कति वटा जिल्लाहरू छन् ?',
//     answers: ['७७', '७६', '७५', '७४'],
//     correctAnswer: '७७',
//   ),
//   Question(
//     id: '4',
//     question: 'नेपालको राष्ट्रिय चरा के हो ?',
//     answers: ['डाँफे', 'काँडे भ्याकुर', 'कालिज', 'काग'],
//     correctAnswer: 'डाँफे',
//   ),
//   Question(
//     id: '5',
//     question: 'नेपालको छेत्रफल कति हो ?',
//     answers: ['१४७,१२८', '१४७,१८१', '१४७,५१६', '१४७,७७७'],
//     correctAnswer: '१४७,५१६',
//   ),
//   Question(
//     id: '6',
//     question: 'नेपालमा मात्रै पाइने चरा कुन हो ? ?',
//     answers: ['डाँफे', 'काँडे भ्याकुर', 'कालिज', 'काग'],
//     correctAnswer: 'काँडे भ्याकुर',
//   ),
//   Question(
//     id: '7',
//     question: 'नेपालको राष्ट्रिय फूल के हो ?',
//     answers: ['गुलाफ', 'लाली गुराँस', 'मखमली', 'चमेली'],
//     correctAnswer: 'चमेली',
//   ),
//   Question(
//     id: '8',
//     question: 'नेपाललको राष्ट्रिय खेल के हो ?',
//     answers: ['भलिबल', 'क्रिकेट', 'डन्डी बियो', 'कबड्डी'],
//     correctAnswer: 'भलिबल',
//   ),
//   Question(
//     id: '9',
//     question: 'नेपालको सबैभन्दा लामो राजमार्ग कुन हो ?',
//     answers: [
//       'सिद्धार्थ राजमार्ग',
//       'पृथ्वी राजमार्ग',
//       'महेन्द्र राजमार्ग',
//       'अरनिको राजमार्ग'
//     ],
//     correctAnswer: 'महेन्द्र राजमार्ग',
//   ),
//   Question(
//     id: '10',
//     question: 'नेपालको सब भन्दा सानो जिल्ला कुन हो ?',
//     answers: ['काठमाण्डु', 'भक्तपुर', 'ललितपुर', 'बसन्तपुर'],
//     correctAnswer: 'भक्तपुर',
//   ),
// ];
