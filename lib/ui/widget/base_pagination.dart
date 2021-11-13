import 'package:flutter/material.dart';

class BasePagination extends StatelessWidget {
  final ScrollController? scrollController;
  final Widget? child;
  final Function? method;
  final bool? loading;

  BasePagination({this.scrollController, this.child, this.method, this.loading});

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController!.position.maxScrollExtent > scrollController!.offset && scrollController!.position.maxScrollExtent - scrollController!.offset <= 200 && !loading!) {
        method!();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: Column(
        children: [
          Expanded(child: child!),
          if (loading!)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
