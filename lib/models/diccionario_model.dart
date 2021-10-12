// To parse this JSON data, do
//
//     final diccionarioModel = diccionarioModelFromJson(jsonString);

import 'dart:convert';

DiccionarioModel diccionarioModelFromJson(String str) => DiccionarioModel.fromJson(json.decode(str));

String diccionarioModelToJson(DiccionarioModel data) => json.encode(data.toJson());

class DiccionarioModel {
  DiccionarioModel({
    required this.text,
    required this.href,
  });

  String text;
  String href;

  factory DiccionarioModel.fromJson(Map<String, dynamic> json) => DiccionarioModel(
        text: json["text"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "href": href,
      };
}
