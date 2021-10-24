import 'package:appls/const.dart';
import 'package:appls/service/auth_service.dart';
import 'package:appls/ui/widget/background.dart';
import 'package:appls/ui/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late final Animation<double> _headerTextAnimation;
  late final AnimationController _animationController;
  final AuthService _authService = AuthService();
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
            children: [
              Header(animation: _headerTextAnimation),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: crtcr,
                  decoration: const InputDecoration(labelText: "Usuario"),
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
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: const Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff3f51b5),
                  ),
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
                    dynamic result = await _authService.signinUsingEmailPassword(crtcr.text, crtpw.text);
                    if (result == null) {
                      setState(() {
                        var _errors = "There is a problem with signing in the user check the credentials ";
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errors)));
                      });
                    } else {
                      // ignore: avoid_print
                      print("signed in succesfully 😊👍👍👍🤞🤞😍👌👌");
                      Navigator.pushReplacementNamed(context, 'HomePage');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(80.0), gradient: const LinearGradient(colors: [Color.fromARGB(255, 255, 136, 34), Color.fromARGB(255, 255, 177, 41)])),
                    child: const Text(
                      "Ingresar",
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
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(builder: (context) => RegisterScreen()),
              //       Navigator.pushNamed(context, 'Registro')
              //       // ),
              //     },
              //     child: const Text(
              //       "¿Ya tienes una cuenta? Crea una",
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

  Scaffold newMethod() {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                width: 80,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Expanded(
              flex: 2,
              child: Text(
                appname,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Rock Salt",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20),

                      decoration: meInputDecoration("Correo", const Icon(Icons.email, size: 35)),
                      onChanged: (value) {
                        // _saveemail(value);
                      },
                      // validator: (value) {
                      //   if (value!.trim().isEmpty) {
                      //     return "Para continuar es necesario que ingrese un correo valido.";
                      //   }
                      //   String pattern1 = r'@live\.uleam\.edu\.ec$';
                      //   // // String pattern1 = r'^[a-zA-Z]\d\d\d\d\d\d\d\d\d\d@live\.uleam\.edu\.ec$';

                      //   // // String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      //   RegExp regExp = new RegExp(pattern1);

                      //   if (!regExp.hasMatch(value)) {
                      //     return "Correo inválido.";
                      //   }
                      // },
                      // controller: controllerEmail,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20),
                      decoration: meInputDecoration("Contraseña", const Icon(Icons.password, size: 35)),
                      obscureText: true,
                      onChanged: (value) {
                        // _saveemail(value);
                      },
                      // validator: (value) {
                      //   if (value!.trim().isEmpty) {
                      //     return "Para continuar es necesario que ingrese un correo valido.";
                      //   }
                      //   String pattern1 = r'@live\.uleam\.edu\.ec$';
                      //   // // String pattern1 = r'^[a-zA-Z]\d\d\d\d\d\d\d\d\d\d@live\.uleam\.edu\.ec$';

                      //   // // String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      //   RegExp regExp = new RegExp(pattern1);

                      //   if (!regExp.hasMatch(value)) {
                      //     return "Correo inválido.";
                      //   }
                      // },
                      // controller: controllerEmail,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Ingresar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const ListTile(
                      title: Text(
                        "¿Olvido su contraseña?",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Aceptas los términos y condiciónes",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontFamily: "Rock Salt",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration meInputDecoration(String labeltext1, Icon icono) {
    return InputDecoration(
      labelText: labeltext1,
      labelStyle: const TextStyle(fontSize: 20),
      fillColor: Colors.white,
      prefixIcon: icono,
      contentPadding: const EdgeInsets.all(20.0),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
