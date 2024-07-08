import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  TAppTheme._();

  static final TextTheme lightTextTheme = TextTheme(
    headlineSmall: GoogleFonts.montserrat(
      color: Colors.black87,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 24,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: Colors.black87,
      fontSize: 16,
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headlineSmall: GoogleFonts.montserrat(
      color: Colors.white70,
    ),
    titleMedium: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 24,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: Colors.white70,
      fontSize: 16,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
  );
}
