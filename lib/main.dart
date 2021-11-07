import 'package:appls/const.dart';
import 'package:appls/models/user_model.dart';
import 'package:appls/route/routers.dart';
import 'package:appls/service/auth_service.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:appls/theme.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print('background message ${message.notification!.body}');
}

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  final presf = SPUsuarios();
  await presf.initPrefs();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MultiProvider(
    providers: [
      StreamProvider<UserModel?>.value(
        initialData: null,
        catchError: (_, op) => null,
        value: AuthService().user,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplashScreen',
      theme: myTheme,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
