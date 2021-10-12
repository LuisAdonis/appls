import 'package:shared_preferences/shared_preferences.dart';

class SPUsuarios {
  static final SPUsuarios _instancia = SPUsuarios._internal();
  factory SPUsuarios() {
    return _instancia;
  }
  SPUsuarios._internal();
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get audio {
    return _prefs.getBool('audio') ?? false;
  }

  set audio(bool value) {
    _prefs.setBool('audio', value);
  }
}
