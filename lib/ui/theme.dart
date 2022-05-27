import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const blucolor = Color(0X90BEDE);
const blucolor2 = Color(0X7FEFBD);

class Themes {
  static final light = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color.fromARGB(255, 125, 124, 124),
    ),
  );
}

TextStyle get buttonStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(255, 255, 255, 0.8),
    ),
  );
}
