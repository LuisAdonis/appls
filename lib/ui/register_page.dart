import 'package:appls/service/auth_service.dart';
import 'package:appls/ui/widget/background.dart';
import 'package:appls/ui/widget/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  late final Animation<double> _headerTextAnimation;
  late final AnimationController _animationController;
  final AuthService _authService = AuthService();
  TextEditingController crtname = TextEditingController();
  TextEditingController crtcr = TextEditingController();
  TextEditingController crtpw = TextEditingController();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Header(animation: _headerTextAnimation),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: crtname,
                  decoration: const InputDecoration(labelText: "Nombre"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: crtcr,
                  decoration: const InputDecoration(labelText: "Usuario/Correo"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: crtpw,
                  decoration: const InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xff3f51b5)),
                    ),
                    primary: const Color(0xff3f51b5),
                  ),
                  onPressed: () async {
                    dynamic result = await _authService.signUpWithEmailPassword(email: crtcr.text, name: crtname.text, password: crtpw.text);
                    if (result == null) {
                      setState(() {
                        var _errors = "There is a problem with signing in the user check the credentials ";
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errors)));
                      });
                    } else {
                      // ignore: avoid_print
                      print("signed in succesfully 😊👍👍👍🤞🤞😍👌👌");
                      await FirebaseAuth.instance.currentUser!.reload();
                      Navigator.pushReplacementNamed(context, 'HomePage');
                    }
                  },
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  // textColor: Colors.white,
                  // padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Crear Cuenta",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //   child: GestureDetector(
              //     onTap: () => {
              //       Navigator.pop(context),
              //     },
              //     child: const Text(
              //       "Si ya tienes una cuentra ingresa aqui!",
              //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff3f51b5)),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
