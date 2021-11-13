// To parse this JSON data, do
//
//     final libroModel = libroModelFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

LibroModel libroModelFromJson(String str) => LibroModel.fromJson(json.decode(str));

String libroModelToJson(LibroModel data) => json.encode(data.toJson());

class LibroModel {
  LibroModel({
    required this.id,
    required this.autor,
    required this.capitulos,
    required this.fecha,
    required this.imgUrl,
    required this.nombrelibro,
    required this.tiempor,
  });

  String id;
  String autor;
  String capitulos;
  int fecha;
  String imgUrl;
  String nombrelibro;
  String tiempor;

  factory LibroModel.fromJson(Map<String, dynamic> json) => LibroModel(
        id: json["id"],
        autor: json["autor"],
        capitulos: json["capitulos"],
        fecha: json["fecha"],
        imgUrl: json["imgUrl"],
        nombrelibro: json["nombrelibro"],
        tiempor: json["tiempor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "autor": autor,
        "capitulos": capitulos,
        "fecha": fecha,
        "imgUrl": imgUrl,
        "nombrelibro": nombrelibro,
        "tiempor": tiempor,
      };

  LibroModel.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        autor = snapshot.value["autor"],
        capitulos = snapshot.value["capitulos"],
        fecha = snapshot.value["fecha"],
        imgUrl = snapshot.value["imgUrl"],
        nombrelibro = snapshot.value["nombrelibro"],
        tiempor = snapshot.value["tiempor"];
}

class Capitulo {
  Capitulo({
    required this.url,
    required this.img,
  });

  String url;
  String img;

  factory Capitulo.fromJson(Map<String, dynamic> json) => Capitulo(
        url: json["url"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "img": img,
      };
  Capitulo.fromSnapshot(DataSnapshot snapshot)
      : url = snapshot.value["url"],
        img = snapshot.value["img"];
}
