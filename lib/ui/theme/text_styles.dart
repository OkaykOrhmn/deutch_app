import 'package:flutter/material.dart';

const _defaultFontFamily = 'IranSANS';
//Headline
TextStyle headline1 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 24, fontFamily: _defaultFontFamily);
TextStyle headline2 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, fontFamily: _defaultFontFamily);
TextStyle headline3 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18, fontFamily: _defaultFontFamily);
TextStyle headline4 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, fontFamily: _defaultFontFamily);
TextStyle headline5 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 14, fontFamily: _defaultFontFamily);
TextStyle headline6 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 12, fontFamily: _defaultFontFamily);
//Headline
//Body
TextStyle body1 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 24,
    fontFamily: _defaultFontFamily);
TextStyle body2 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    fontFamily: _defaultFontFamily);
TextStyle body3 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    fontFamily: _defaultFontFamily);
TextStyle body4 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    fontFamily: _defaultFontFamily);
TextStyle body5 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    fontFamily: _defaultFontFamily);
TextStyle body6 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    fontFamily: _defaultFontFamily);
//Body

extension AppTextStyle on TextTheme {
  TextStyle get headerBold => headline3;
  TextStyle get header => body3;

  TextStyle get titleBold => headline4;
  TextStyle get title => body4;

  TextStyle get descBold => headline5;
  TextStyle get desc => body5;

  TextStyle get tiny => body6;
}
