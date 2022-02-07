import 'dart:ui';

import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool darkTheme, BuildContext context) {
    ThemeData _light = ThemeData.light().copyWith(
      primaryColor: Colors.black,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
        headline1: TextStyle(
            fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.w400),
        headline4: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
        headline5: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto-Regular',
            fontSize: 16,
            fontWeight: FontWeight.w400),
        subtitle1: TextStyle(color: Colors.grey, fontSize: 14),
        subtitle2: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
        headline6: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto-Regular',
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );

    ThemeData _dark = ThemeData.dark().copyWith(
      primaryColor: Colors.white,
      textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.grey[300], fontWeight: FontWeight.w300, fontSize: 16),
        bodyText2: TextStyle(
            color: Colors.grey[300], fontWeight: FontWeight.w300, fontSize: 14),
        headline1: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey[300]),
        headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        headline4: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
        headline5: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 16,
            fontWeight: FontWeight.w400),
        subtitle1: TextStyle(color: Colors.grey[300], fontSize: 14),
        subtitle2: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
        headline6: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );

    return darkTheme ? _dark : _light;
  }
}
