import 'package:appls/ui/utils/trackbottombar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;
  final bool isLoaded;
  const BaseScaffold({Key? key, required this.child, required this.isLoaded}) : super(key: key);
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !widget.isLoaded ? const CircularProgressIndicator() : widget.child,
        const Positioned(
          bottom: 12.0,
          left: 0.0,
          height: 75,
          right: 0.0,
          child: Padding(
            padding: EdgeInsets.only(right: 8, left: 8),
            child: TrackBottomBar(),
          ),
        ),
      ],
    );
  }
}
