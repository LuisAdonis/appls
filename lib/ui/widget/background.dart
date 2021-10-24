import 'package:appls/const.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          const SizedBox(
            height: 36.5,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
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
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
