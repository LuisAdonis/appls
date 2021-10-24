import 'package:appls/ui/widget/fade_siled_transd.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
              'Bienvenido a APPLS',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 16.0,
            child: Text(
              "Lenguaje de Señas UEJM",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
