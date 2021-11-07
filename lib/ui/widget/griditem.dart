import 'package:appls/ui/utils/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget singleMyCourse1({
  required String image,
  required String title,
  required String type,
  required String status,
  required bool lado,
  required String startColor,
  required String endColor,
  Null Function()? ontap,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, left: 4, right: 4, bottom: 8),
    child: Ink(
      decoration: boxdecoration(lado: lado, starcolo: startColor, endcoloend: endColor),
      child: InkWell(
        onTap: ontap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 135, left: 16, right: 16, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              type,
                              textAlign: TextAlign.center,
                              textScaleFactor: 0.9,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: 0.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 8,
              right: 8,
              child: SizedBox(
                width: 100,
                height: 125,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // child: CircleAvatar(
                //   radius: 30.0,
                //   backgroundImage: AssetImage(image),
                //   backgroundColor: Colors.transparent,
                // ),
                // child: Image.asset(image),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget singleMyCourse2({
  required String image,
  required String title,
  required String type,
  required String status,
  required bool lado,
  required String startColor,
  required String endColor,
  Null Function()? ontap,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, left: 4, right: 4, bottom: 8),
    child: Ink(
      decoration: boxdecoration(lado: lado, starcolo: startColor, endcoloend: endColor),
      child: InkWell(
        onTap: ontap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 135, left: 16, right: 16, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              type,
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: 0.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 8,
              right: 8,
              child: SizedBox(
                width: 90,
                height: 125,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset(
                      image,
                      width: 125,
                      height: 175,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // child: CircleAvatar(
                //   radius: 30.0,
                //   backgroundImage: AssetImage(image),
                //   backgroundColor: Colors.transparent,
                // ),
                // child: Image.asset(image),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget singleMyCourse3({
  required String image,
  required String title,
  required String type,
  required String status,
  required bool lado,
  required String startColor,
  required String endColor,
  Null Function()? ontap,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, left: 4, right: 4, bottom: 8),
    child: Ink(
      decoration: boxdecoration(lado: lado, starcolo: startColor, endcoloend: endColor),
      child: InkWell(
        onTap: ontap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 135, left: 16, right: 16, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              type,
                              textAlign: TextAlign.center,
                              textScaleFactor: 0.9,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                letterSpacing: 0.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 8,
              right: 8,
              child: SizedBox(
                width: 100,
                height: 125,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                // child: CircleAvatar(
                //   radius: 30.0,
                //   backgroundImage: AssetImage(image),
                //   backgroundColor: Colors.transparent,
                // ),
                // child: Image.asset(image),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

BoxDecoration boxdecoration({
  bool lado = false,
  required String endcoloend,
  required String starcolo,
}) {
  return BoxDecoration(
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: HexColor(endcoloend).withOpacity(0.6),
        offset: const Offset(1.1, 4.0),
        blurRadius: 8.0,
      ),
    ],
    gradient: LinearGradient(
      colors: <HexColor>[
        HexColor(starcolo),
        HexColor(endcoloend),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: const BorderRadius.only(
      bottomRight: Radius.circular(8.0),
      bottomLeft: Radius.circular(8.0),
      topLeft: Radius.circular(8.0),
      // topLeft: lado ? Radius.circular(54.0) : Radius.circular(0),
      topRight: Radius.circular(8.0),
      // topRight: lado ? Radius.circular(0) : Radius.circular(54.0),
    ),
  );
}
