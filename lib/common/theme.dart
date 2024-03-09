import 'package:flutter/material.dart';

final Color oceanGreen = const Color.fromARGB(255, 85, 205, 150);
final Color aquamarine = const Color.fromARGB(255, 145, 230, 200);
final Color raisinBlack = const Color.fromARGB(255, 45, 40, 55);

final ThemeData appTheme = ThemeData(
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(primary: oceanGreen),
  ),
  primaryColor: raisinBlack,
  // ignore: deprecated_member_use
  accentColor: oceanGreen,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(primary: oceanGreen),
  ),
);
