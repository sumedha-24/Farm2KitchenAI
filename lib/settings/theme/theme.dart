import 'package:flutter/material.dart';

// Kinda like a getter to import theme from other files
final ThemeData f2kTheme = _f2kTheme();

//Define Base theme for app
ThemeData _f2kTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: Color.fromARGB(255, 24, 137, 1),
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(2255, 24, 137, 1),
      onSecondary: Colors.white,
      error: Colors.red,
      background: const Color.fromARGB(255, 24, 137, 1),
      onBackground: Colors.black,
    ),
    textTheme: _f2kTextTheme(base.textTheme),
    // below text theme add this
    // Define styles for elevated button
    elevatedButtonTheme: _elevatedButtonTheme(base.elevatedButtonTheme),

    // Set Themes for Input Your homework
    inputDecorationTheme: _f2kInputTheme(base.inputDecorationTheme),
    // Define theme for text input
  );
}


InputDecorationTheme _f2kInputTheme(InputDecorationTheme base) => base.copyWith();

TextTheme _f2kTextTheme(TextTheme base) => base.copyWith(

    displayLarge: base.displayLarge!.copyWith(
        fontFamily: "Proxima Nova Rg Regular",
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white),
// for widgets heading/title
    displayMedium: base.displayMedium!.copyWith(
      fontFamily: "Proxima Nova Rg Regular",
      fontSize: 26,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
// for sub-widgets heading/title
    displaySmall: base.displaySmall!.copyWith(
      fontFamily: "Proxima Nova Rg Regular",
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(255, 0, 133, 40),
    ),
// for widgets contents/paragraph
    bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: "Proxima Nova Rg Regular",
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black),
// for sub-widgets contents/paragraph
    bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: "Proxima Nova Rg Regular",
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: Colors.black),
    bodySmall: base.bodySmall!.copyWith(
        fontFamily: "Proxima Nova Rg Regular",
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Color.fromARGB(255, 0, 0, 0)),
    titleLarge: base.titleLarge!.copyWith(fontSize: 20));

InputDecorationTheme _inputDecorationTheme(InputDecorationTheme base) =>
    const InputDecorationTheme(
// Label color for the input widget
      labelStyle: TextStyle(color: Colors.black),
// Define border of input form while focused on
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    );

ElevatedButtonThemeData _elevatedButtonTheme(ElevatedButtonThemeData base) =>
    ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 30, 223, 12),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
