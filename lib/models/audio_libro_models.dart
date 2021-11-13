// To parse this JSON data, do
//
//     final audioLibroModels = audioLibroModelsFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

AudioLibroModels audioLibroModelsFromJson(String str) => AudioLibroModels.fromJson(json.decode(str));

String audioLibroModelsToJson(AudioLibroModels data) => json.encode(data.toJson());

class AudioLibroModels {
  AudioLibroModels({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.url,
    required this.descripcion,
    required this.capitulospartes,
    required this.capitulos,
  });

  String id;
  String nombre;
  String imagen;
  String url;
  String descripcion;
  List capitulospartes;
  String capitulos;

  factory AudioLibroModels.fromJson(Map<String, dynamic> json) => AudioLibroModels(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        url: json["url"],
        descripcion: json["descripcion"],
        capitulospartes: json["capitulospartes"],
        capitulos: json["capitulos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "url": url,
        "descripcion": descripcion,
        "capitulospartes": capitulospartes,
        "capitulos": capitulos,
      };

  AudioLibroModels.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        nombre = snapshot.value["nombre"],
        capitulospartes = List.from(snapshot.value["capitulospartes"]),
        imagen = snapshot.value["imagen"],
        descripcion = snapshot.value["descripcion"],
        url = snapshot.value["url"],
        capitulos = snapshot.value["capitulos"];

  @override
  String toString() {
    return 'StadisModel(id: $id, nombre: $nombre, capitulospartes: $capitulospartes, imagen: $imagen,descripcion:$descripcion,url:$url,capitulos$capitulos)';
  }
}
