import 'package:flutter/material.dart';

Color myGreen = const Color(0xff25c06d);
Color myRed = const Color(0xffff5147);
Color myYellow = const Color(0xfff9c50b);
Color myOrange = const Color(0xffff9d42);
Color myBlue = const Color(0xff42a0ff);
Color darkBackgroundColor = const  Color(0xff273746);

void navigateTo(context, destination) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return destination;
  }));
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: myGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 10.0,
        ),
      )
      .close;
}
