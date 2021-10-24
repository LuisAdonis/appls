// import 'dart:math';

// import 'package:appls/const.dart';
// import 'package:appls/service/auth_service.dart';
// import 'package:appls/ui/utils/hexcolor.dart';
// import 'package:appls/ui/widget/griditem.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class Login2Page extends StatefulWidget {
//   const Login2Page({Key? key}) : super(key: key);

//   @override
//   State<Login2Page> createState() => _Login2PageState();
// }

// class _Login2PageState extends State<Login2Page> with SingleTickerProviderStateMixin {
//   final AuthService _authService = AuthService();

//   late final AnimationController _animationController;
//   late final Animation<double> _headerTextAnimation;
//   late final Animation<double> _formElementAnimation;
//   late final Animation<double> _whiteTopClipperAnimation;
//   late final Animation<double> _blueTopClipperAnimation;
//   late final Animation<double> _greyTopClipperAnimation;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // final user = Provider.of<UserModel?>(context);
//     return newLogin();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//     final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
//     _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(
//         0.0,
//         0.6,
//         curve: Curves.easeInOut,
//       ),
//     ));
//     _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(
//         0.7,
//         1.0,
//         curve: Curves.easeInOut,
//       ),
//     ));
//     final clipperOffsetTween = Tween<double>(
//       begin: 412,
//       end: 0.0,
//     );
//     _blueTopClipperAnimation = clipperOffsetTween.animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(
//           0.2,
//           0.7,
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );
//     _greyTopClipperAnimation = clipperOffsetTween.animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(
//           0.35,
//           0.7,
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );
//     _whiteTopClipperAnimation = clipperOffsetTween.animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(
//           0.5,
//           0.7,
//           curve: Curves.easeInOut,
//         ),
//       ),
//     );

//     _animationController.forward();
//   }

//   Widget newLogin() {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 30,
//             left: 20,
//             child: Container(
//               height: size.height / 6,
//               width: size.height / 6,
//               decoration: const BoxDecoration(shape: BoxShape.circle, color: bubbleColor),
//             ),
//           ),
//           Positioned(
//             bottom: 30,
//             right: 20,
//             child: Container(
//               height: size.height / 7,
//               width: size.height / 7,
//               decoration: const BoxDecoration(shape: BoxShape.circle, color: bubbleColor),
//             ),
//           ),
//           Positioned(
//             bottom: 234,
//             left: 50,
//             child: Container(
//               height: size.height / 4.5,
//               width: size.height / 4.5,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: bubbleColor,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 80,
//             right: 0,
//             child: Container(
//               height: size.height / 5,
//               width: size.height / 9,
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(100),
//                     bottomLeft: Radius.circular(100),
//                   ),
//                   color: bubbleColor),
//             ),
//           ),
//           Positioned(
//             top: 230,
//             right: 30,
//             child: Container(
//               height: size.height / 10,
//               width: size.height / 10,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: bubbleColor,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 24,
//             left: 0,
//             child: Container(
//               height: size.height / 5,
//               width: size.height / 5,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(80),
//                   topRight: Radius.circular(130),
//                   bottomRight: Radius.circular(80),
//                 ),
//                 color: bubbleColor,
//               ),
//             ),
//           ),

//           // AnimatedBuilder(
//           //   animation: _whiteTopClipperAnimation,
//           //   builder: (_, Widget? child) {
//           //     return ClipPath(
//           //       clipper: WhiteTopClipper(
//           //         yOffset: _whiteTopClipperAnimation.value,
//           //       ),
//           //       child: child,
//           //     );
//           //   },
//           //   child: Container(color: Colors.grey),
//           // ),
//           // AnimatedBuilder(
//           //   animation: _greyTopClipperAnimation,
//           //   builder: (_, Widget? child) {
//           //     return ClipPath(
//           //       clipper: GreyTopClipper(
//           //         yOffset: _greyTopClipperAnimation.value,
//           //       ),
//           //       child: child,
//           //     );
//           //   },
//           //   child: Container(color: Colors.blue),
//           // ),
//           // AnimatedBuilder(
//           //   animation: _blueTopClipperAnimation,
//           //   builder: (_, Widget? child) {
//           //     return ClipPath(
//           //       clipper: BlueTopClipper(
//           //         yOffset: _blueTopClipperAnimation.value,
//           //       ),
//           //       child: child,
//           //     );
//           //   },
//           //   child: Container(color: Colors.white),
//           // ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 32.0),
//               child: Column(
//                 children: <Widget>[
//                   const Spacer(
//                     flex: 2,
//                   ),
//                   Header(animation: _headerTextAnimation),
//                   const Spacer(
//                     flex: 10,
//                   ),
//                   LoginForm(animation: _formElementAnimation),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Scaffold> newMethod(Size size, BuildContext context) async {
//     return Scaffold(
//       // backgroundColor: Colors.teal,
//       // appBar: AppBar(
//       //   actions: [
//       //     IconButton(
//       //         onPressed: () async {
//       //           await _authService
//       //               .signout()
//       //               // ignore: avoid_print
//       //               .then((value) => print(value.toString()));
//       //         },
//       //         icon: Icon(Icons.logout))
//       //   ],
//       //   title: Text("Loanding ${user?.userId}"),
//       // ),
//       body: Column(
//         children: [
//           SafeArea(
//             child: Container(
//               height: 45,
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             child: const Text(
//               "LOGIN",
//               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 36),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           SizedBox(height: size.height * 0.03),
//           Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.symmetric(horizontal: 40),
//             child: const TextField(
//               decoration: InputDecoration(labelText: "Usuario"),
//             ),
//           ),
//           SizedBox(height: size.height * 0.03),
//           Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.symmetric(horizontal: 40),
//             child: const TextField(
//               decoration: InputDecoration(labelText: "Contraseña"),
//               obscureText: true,
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerRight,
//             margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//             child: const Text(
//               "¿Olvidaste tu contraseña?",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Color(0xff3f51b5),
//               ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.05),
//           Container(
//             alignment: Alignment.centerRight,
//             margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 elevation: 10,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   side: const BorderSide(color: Color(0xff3f51b5)),
//                 ),
//                 primary: const Color(0xff3f51b5),
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(context, 'dashboard');
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 // decoration: BoxDecoration(borderRadius: BorderRadius.circular(80.0), gradient: const LinearGradient(colors: [Color.fromARGB(255, 255, 136, 34), Color.fromARGB(255, 255, 177, 41)])),
//                 child: const Text(
//                   "Ingresar",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerRight,
//             margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//             child: GestureDetector(
//               onTap: () => {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => RegisterScreen()),
//                 Navigator.pushNamed(context, 'register')
//                 // ),
//               },
//               child: const Text(
//                 "¿Ya tienes una cuenta? Crea una",
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff3f51b5)),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.white,
//                 onPrimary: Colors.black,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               icon: const FaIcon(
//                 FontAwesomeIcons.google,
//                 color: Colors.red,
//               ),
//               onPressed: () async {
//                 dynamic result = await _authService.googleLogin();
//                 if (result == null) {
//                   setState(() {
//                     var _errors = "There is a problem with signing in the user check the credentials ";
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errors)));
//                   });
//                 } else {
//                   // ignore: avoid_print
//                   print("signed in succesfully 😊👍👍👍🤞🤞😍👌👌");
//                   Navigator.pushReplacementNamed(context, 'HomePage');
//                 }
//               },
//               label: const Text("Iniciar con google"),
//             ),
//           ),
//           IconButton(
//             onPressed: () async {
//               dynamic result = await _authService.signinAnon();
//               if (result == null) {
//                 setState(() {
//                   var _errors = "There is a problem with signing in the user check the credentials ";
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errors)));
//                 });
//               } else {
//                 // ignore: avoid_print
//                 print("signed in succesfully 😊👍👍👍🤞🤞😍👌👌");
//                 Navigator.pushReplacementNamed(context, 'HomePage');
//               }
//             },
//             icon: const Icon(Icons.login),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WhiteTopClipper extends CustomClipper<Path> {
//   final double yOffset;

//   const WhiteTopClipper({
//     required this.yOffset,
//   });

//   @override
//   Path getClip(Size size) => Path()
//     ..lineTo(0.0, 310.0 + yOffset)
//     ..quadraticBezierTo(
//       size.width / 2,
//       310.0 + yOffset,
//       size.width,
//       200.0 + yOffset,
//     )
//     ..lineTo(size.width, 0.0)
//     ..close();

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class GreyTopClipper extends CustomClipper<Path> {
//   final double yOffset;

//   const GreyTopClipper({
//     required this.yOffset,
//   });

//   @override
//   Path getClip(Size size) => Path()
//     ..lineTo(0.0, 265.0 + yOffset)
//     ..quadraticBezierTo(
//       size.width / 2,
//       285.0 + yOffset,
//       size.width,
//       185.0 + yOffset,
//     )
//     ..lineTo(size.width, 0.0)
//     ..close();

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class BlueTopClipper extends CustomClipper<Path> {
//   final double yOffset;

//   const BlueTopClipper({
//     required this.yOffset,
//   });

//   @override
//   Path getClip(Size size) => Path()
//     ..lineTo(0.0, 220.0 + yOffset)
//     ..quadraticBezierTo(
//       size.width / 2.2,
//       260.0 + yOffset,
//       size.width,
//       170.0 + yOffset,
//     )
//     ..lineTo(size.width, 0.0)
//     ..close();

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class Header extends StatelessWidget {
//   final Animation<double> animation;

//   const Header({
//     required this.animation,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const SizedBox(height: 16.0),
//           FadeSlideTransition(
//             animation: animation,
//             additionalOffset: 0.0,
//             child: Text(
//               'Bienvenido a APPLS',
//               style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 8),
//           FadeSlideTransition(
//             animation: animation,
//             additionalOffset: 16.0,
//             child: Text(
//               "Lenguaje de Señas UEJM",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black.withOpacity(0.5)),
//             ),
//           ),
//           const SizedBox(height: 8),
//         ],
//       ),
//     );
//   }
// }

// class LoginForm extends StatelessWidget {
//   final Animation<double> animation;

//   const LoginForm({
//     required this.animation,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//     final space = height > 650 ? 16.0 : 8.0;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32),
//       child: Column(
//         children: <Widget>[
//           // FadeSlideTransition(
//           //   animation: animation,
//           //   additionalOffset: 0.0,
//           //   child: const CustomInputField(
//           //     label: 'Username or Email',
//           //     prefixIcon: Icons.person,
//           //     obscureText: true,
//           //   ),
//           // ),
//           // SizedBox(height: space),
//           // FadeSlideTransition(
//           //   animation: animation,
//           //   additionalOffset: space,
//           //   child: const CustomInputField(
//           //     label: 'Password',
//           //     prefixIcon: Icons.lock,
//           //     obscureText: true,
//           //   ),
//           // ),
//           // SizedBox(height: space),
//           // FadeSlideTransition(
//           //   animation: animation,
//           //   additionalOffset: 2 * space,
//           //   child: CustomButton(
//           //     color: Colors.blue,
//           //     textColor: Colors.white,
//           //     text: 'Login to continue',
//           //     onPressed: () {},
//           //   ),
//           // ),
//           SizedBox(height: 2 * space),
//           FadeSlideTransition(
//             animation: animation,
//             additionalOffset: 3 * space,
//             child: CustomButton(
//               color: Colors.white,
//               textColor: Colors.black.withOpacity(0.5),
//               text: 'Continuar con Google',
//               image: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
//               onPressed: () {},
//             ),
//           ),
//           // SizedBox(height: space),
//           // FadeSlideTransition(
//           //   animation: animation,
//           //   additionalOffset: 4 * space,
//           //   child: CustomButton(
//           //     color: Colors.black,
//           //     textColor: Colors.white,
//           //     text: 'Create a Bubble Account',
//           //     onPressed: () {},
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class FadeSlideTransition extends StatelessWidget {
//   final Animation<double> animation;
//   final double additionalOffset;
//   final Widget child;

//   const FadeSlideTransition({
//     required this.animation,
//     required this.additionalOffset,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (_, Widget? builderChild) {
//         return Transform.translate(
//           offset: Offset(
//             0.0,
//             (32.0 + additionalOffset) * (1 - animation.value),
//           ),
//           child: Opacity(
//             opacity: animation.value,
//             child: builderChild,
//           ),
//         );
//       },
//       child: child,
//     );
//   }
// }

// class CustomInputField extends StatelessWidget {
//   final String label;
//   final IconData prefixIcon;
//   final bool obscureText;

//   const CustomInputField({
//     required this.label,
//     required this.prefixIcon,
//     this.obscureText = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(16.0),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
//         ),
//         hintText: label,
//         hintStyle: TextStyle(
//           color: Colors.black.withOpacity(0.5),
//           fontWeight: FontWeight.w500,
//         ),
//         prefixIcon: Icon(
//           prefixIcon,
//           color: Colors.black.withOpacity(0.5),
//         ),
//       ),
//       obscureText: obscureText,
//     );
//   }
// }

// class CustomButton extends StatelessWidget {
//   final Color color;
//   final Color textColor;
//   final String text;
//   final Widget? image;
//   final VoidCallback onPressed;

//   const CustomButton({
//     required this.color,
//     required this.textColor,
//     required this.text,
//     required this.onPressed,
//     this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(
//         minWidth: double.infinity,
//       ),
//       child: image != null
//           ? OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 primary: color,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//               ),
//               onPressed: onPressed,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(right: 32.0),
//                     child: image,
//                   ),
//                   Text(
//                     text,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                           color: textColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ],
//               ),
//             )
//           : TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: color,
//                 padding: const EdgeInsets.all(16.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//               ),
//               onPressed: onPressed,
//               child: Text(
//                 text,
//                 style: Theme.of(context).textTheme.subtitle1!.copyWith(color: textColor, fontWeight: FontWeight.bold),
//               ),
//             ),
//     );
//   }
// }

// class Logo extends StatelessWidget {
//   final Color color;
//   final double size;

//   const Logo({
//     required this.color,
//     required this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 5, left: 4, right: 4, bottom: 8),
//       child: Stack(
//         children: [
//           Positioned(
//             top: 4,
//             left: 0,
//             right: 0,
//             child: Container(
//               width: 100,
//               height: 125,
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.2),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Container(
//             decoration: boxdecoration(lado: false, starcolo: "#738AE6", endcoloend: "#738AE6"),
//             child: Image.asset(
//               "assets/menu/bn.png",
//               width: size,
//             ),
//           ),
//         ],
//       ),
//     );

//     // return Transform.rotate(
//     //   angle: -pi / 4,
//     //   child: Icon(
//     //     Icons.format_bold,
//     //     color: color,
//     //     size: size,
//     //   ),
//     // );
//   }
// }

// BoxDecoration boxdecoration({
//   bool lado = false,
//   required String endcoloend,
//   required String starcolo,
// }) {
//   return BoxDecoration(
//     boxShadow: <BoxShadow>[
//       BoxShadow(
//         color: HexColor(endcoloend).withOpacity(0.6),
//         offset: const Offset(1.1, 4.0),
//         blurRadius: 8.0,
//       ),
//     ],
//     gradient: LinearGradient(
//       colors: <HexColor>[
//         HexColor(starcolo),
//         HexColor(endcoloend),
//       ],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     ),
//     borderRadius: const BorderRadius.only(
//       bottomRight: Radius.circular(8.0),
//       bottomLeft: Radius.circular(8.0),
//       topLeft: Radius.circular(8.0),
//       // topLeft: lado ? Radius.circular(54.0) : Radius.circular(0),
//       topRight: Radius.circular(8.0),
//       // topRight: lado ? Radius.circular(0) : Radius.circular(54.0),
//     ),
//   );
// }
