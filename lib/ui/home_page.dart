import 'package:appls/ui/dashboard/dashboardscreen.dart';
import 'package:appls/ui/dashboard/estadistias_screen.dart';
import 'package:appls/ui/logins.dart';
import 'package:appls/ui/register_page.dart';
import 'package:appls/ui/widget/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listTitle = [
    'Estudiar',
    'Diccionario',
    'Evaluación',
    'Lenguaje ML',
    'Institucion',
    'Acerca De',
    'Contactenos',
  ];
  List<IconData> icons = [
    Icons.people,
    Icons.book,
    Icons.done_all,
    Icons.accessibility,
    Icons.account_balance,
    Icons.feedback,
    Icons.contact_page,
  ];
  DrawerIndex? drawerIndex;
  Widget? screenView;
  bool estado = true;

  late FirebaseMessaging messaging;
  @override
  void initState() {
    drawerIndex = DrawerIndex.home;
    screenView = const DashboardScreen();
    // FirebaseCrashlytics.instance.crash();
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   // ignore: avoid_print
    //   print(value);
    // });
    // messaging.subscribeToTopic("messaging");

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // ignore: avoid_print
      print("message recieved");
      // ignore: avoid_print
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // ignore: avoid_print
      print('Message clicked! $message');
    });
    super.initState();
    asaa();
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.home) {
        setState(() {
          screenView = const DashboardScreen();
        });
      } else if (drawerIndex == DrawerIndex.login) {
        setState(() {
          screenView = const LoginPage();
        });
      } else if (drawerIndex == DrawerIndex.registro) {
        setState(() {
          screenView = const RegisterPage();
        });
      } else if (drawerIndex == DrawerIndex.share) {
        setState(() {
          screenView = const EstadistiasScreen();
        });
      } else {
        //do in your way......
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrawerUserController(
        screenIndex: drawerIndex,
        drawerWidth: MediaQuery.of(context).size.width * 0.50,
        onDrawerCall: (DrawerIndex drawerIndexdata) {
          changeIndex(drawerIndexdata);
          //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
        },
        screenView: screenView,
        //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
      ),
    );
  }

  Future<void> asaa() async {
    await FirebaseAuth.instance.currentUser!.reload().then((value) {
      print("object");
    });
  }
}
