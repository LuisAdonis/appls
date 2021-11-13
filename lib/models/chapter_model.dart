import 'package:firebase_database/firebase_database.dart';

class Chapter {
  final String id;
  final int cap;
  final String lector;
  final String tiempo;
  final String url;

  Chapter(
    this.id,
    this.cap,
    this.lector,
    this.tiempo,
    this.url,
  );
  Chapter.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        cap = snapshot.value["cap"],
        lector = snapshot.value["lector"],
        tiempo = snapshot.value["tiempo"],
        url = snapshot.value["url"];
}
