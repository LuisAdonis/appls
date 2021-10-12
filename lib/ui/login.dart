import 'package:appls/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserModel?>(context);
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           await _authService
      //               .signout()
      //               // ignore: avoid_print
      //               .then((value) => print(value.toString()));
      //         },
      //         icon: Icon(Icons.logout))
      //   ],
      //   title: Text("Loanding ${user?.userId}"),
      // ),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 45,
            ),
          ),
          IconButton(
            onPressed: () async {
              dynamic result = await _authService.signinAnon();
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
            icon: const Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
