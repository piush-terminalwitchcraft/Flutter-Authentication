import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllStyles {
  Map<int, Color> color_white = {
    50: Color.fromARGB(255, 255, 255, 255),
    100: Color.fromARGB(255, 255, 255, 255),
    200: Color.fromARGB(255, 255, 255, 255),
    300: Color.fromARGB(255, 255, 255, 255),
    400: Color.fromARGB(255, 255, 255, 255),
    500: Color.fromARGB(255, 255, 255, 255),
    600: Color.fromARGB(255, 255, 255, 255),
    700: Color.fromARGB(255, 255, 255, 255),
    800: Color.fromARGB(255, 255, 255, 255),
    900: Color.fromARGB(255, 255, 255, 255),
  };

  TextStyle DefaultStyle() {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      letterSpacing: 0.5,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle DefaultStyleWithColor(MaterialColor _color) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      letterSpacing: 0.5,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _color,
    );
  }

  DefaultButtonStyle(MaterialColor _color) {
    return ElevatedButton.styleFrom(
      primary: _color,
      fixedSize: Size(100, 40),
      textStyle:
          AllStyles().DefaultStyleWithColor(MaterialColor(0000, color_white)),
    );
  }
}
