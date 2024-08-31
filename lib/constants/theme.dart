import 'package:flutter/material.dart';

class Colour {
  static const dark = Colors.black;
  static const white = Colors.white;
  static const blue = Colors.blue;
  static const lightDark = Color.fromARGB(95, 186, 179, 179);
  static const darkBlue = Color.fromARGB(255, 20, 91, 150);
  static const green = Colors.green;
  static const red = Color.fromARGB(255, 223, 97, 88);
}

class CustomTextStyle {
  static const heading = TextStyle(
    color: Colors.white,
    fontSize: 35,
    fontWeight: FontWeight.w400,
  );
  static const title = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
}
