import 'package:flutter/material.dart';

class CupcakesbrUI {
  CupcakesbrUI._();
  static final ThemeData theme = ThemeData(
    primaryColor: const Color.fromARGB(80, 222, 62, 129),
    primaryColorDark: const Color(0xFF00343F),
    fontFamily: 'mplus1',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(178, 77, 0, 125),
        textStyle: const TextStyle(fontFamily: 'mplus1'),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      selectedLabelStyle: textBold,
      unselectedItemColor: Colors.grey[400],
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[400],
      ),
    ),
  );

  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
}
