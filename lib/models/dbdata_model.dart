import 'package:firebase_database/firebase_database.dart';

class DbDatosModel {
  DbDatosModel({
    this.nombre,
    this.imagen,
    this.nombrearchivo,
    this.urldata,
    this.video,
  });

  String? key;
  String? nombre;
  String? imagen;
  String? nombrearchivo;
  String? urldata;
  String? video;
  DbDatosModel.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        nombre = snapshot.value["nombre"],
        imagen = snapshot.value["imagen"],
        urldata = snapshot.value["urldata"],
        video = snapshot.value["video"],
        nombrearchivo = snapshot.value["nombrearchivo"];

  toJson() {
    return {
      "nombre": nombre,
      "imagen": imagen,
      "urldata": urldata,
      "video": video,
      "nombrearchivo": nombrearchivo,
    };
  }
}
