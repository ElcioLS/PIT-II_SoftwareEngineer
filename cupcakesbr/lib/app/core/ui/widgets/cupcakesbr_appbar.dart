import 'package:flutter/material.dart';

class CupcakesbrAppBar extends AppBar {
  CupcakesbrAppBar({
    Key? key,
    double elevation = 2,
  }) : super(
          key: key,
          backgroundColor: Colors.white,
          elevation: elevation,
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.all(20),
            height: 120,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        );
}
