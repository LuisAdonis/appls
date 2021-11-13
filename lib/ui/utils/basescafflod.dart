import 'package:appls/ui/utils/trackbottombar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatefulWidget {
  final Widget child;
  final bool isLoaded;
  BaseScaffold({required this.child, required this.isLoaded});
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          !widget.isLoaded ? const CircularProgressIndicator() : widget.child,
          Positioned(
            bottom: 12.0,
            left: 0.0,
            height: 75,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: TrackBottomBar(),
            ),
          ),
        ],
      ),
    );
  }
}
