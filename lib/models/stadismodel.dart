// To parse this JSON data, do
//
//     final stadisModel = stadisModelFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

StadisModel stadisModelFromJson(String str) => StadisModel.fromJson(json.decode(str));

String stadisModelToJson(StadisModel data) => json.encode(data.toJson());

class StadisModel {
  StadisModel({
    required this.categoria,
    required this.data,
    required this.fecha,
    required this.id,
    required this.preguntascorrectas,
    required this.preguntastotal,
  });

  String categoria;
  List data;
  int fecha;
  String id;
  int preguntascorrectas;
  int preguntastotal;

  factory StadisModel.fromJson(Map<String, dynamic> json) => StadisModel(
        categoria: json["categoria"],
        data: json["data"],
        fecha: json["fecha"],
        id: json["id"],
        preguntascorrectas: json["preguntascorrectas"],
        preguntastotal: json["preguntastotal"],
      );

  StadisModel.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        categoria = snapshot.value["categoria"],
        data = List.from(snapshot.value["data"]),
        fecha = snapshot.value["fecha"],
        preguntascorrectas = snapshot.value["preguntascorrectas"],
        preguntastotal = snapshot.value["preguntastotal"];

  @override
  String toString() {
    return 'StadisModel(id: $id, categoria: $categoria, data: $data, fecha: $fecha,preguntascorrectas:$preguntascorrectas,preguntastotal:$preguntastotal)';
  }

  Map<String, dynamic> toJson() => {
        "categoria": categoria,
        "data": data,
        "fecha": fecha,
        "id": id,
        "preguntascorrectas": preguntascorrectas,
        "preguntastotal": preguntastotal,
      };
}
