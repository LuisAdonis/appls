import 'package:appls/const.dart';
import 'package:faker/faker.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });

    try {
      versionCheck(context);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  versionCheck(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetchAndActivate();
      bool a = remoteConfig.getBool('force_status');
      double newVersion = double.parse(remoteConfig.getString('force_update_current_version').trim().replaceAll(".", ""));
      // ignore: avoid_print
      print("newVersion: $newVersion currentVersion $currentVersion");
      if (a) {
        if (newVersion > currentVersion) {
          _showVersionDialog(context);
        } else {
          fn();
        }
      } else {
        _showVersionDialogDisable(context);
      }
    } on PlatformException catch (exception) {
      // Fetch exception.
      // ignore: avoid_print
      print("data: $exception");
    } catch (exception) {
      // ignore: avoid_print
      print('Unable to fetch remote config. Cached or default values will be used');
      // ignore: avoid_print
      print(exception);
    }
  }

  Future<void> fn() async {
    controller.forward().then((value) {
      Navigator.pushReplacementNamed(context, 'HomePage');
    });
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Nueva actualización disponible";
        String message = "Hay una versión nueva de la aplicación disponible, actualícela ahora.";
        String btnLabel = "Actualizar ahora";
        String btnLabelCancel = "Más tarde";
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            OutlinedButton(
                child: Text(btnLabel),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  //  _launchURL(PLAY_STORE_URL);
                }),
            OutlinedButton(
              child: Text(btnLabelCancel),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showVersionDialogDisable(context) async {
    var faker = Faker();
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Estado de la app";
        String message = "${faker.lorem.sentence()}?";
        String btnLabel = "Actualizar ahora";
        String btnLabelCancel = "Más tarde";
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            OutlinedButton(
                child: Text(btnLabel),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  //  _launchURL(PLAY_STORE_URL);
                }),
            OutlinedButton(
              child: Text(btnLabelCancel),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
          Positioned(
            top: 200,
            left: size.height * 0.010,
            child: RichText(
              text: const TextSpan(
                  text: "APPLS",
                  style: TextStyle(
                    fontSize: 50,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\nLenguaje de Señas \nUEJM",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ]),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: Container(
              color: Colors.teal,
              child: LinearProgressIndicator(
                value: controller.value,
              ),
            ),
          )
        ],
      ),
    );
  }
}
