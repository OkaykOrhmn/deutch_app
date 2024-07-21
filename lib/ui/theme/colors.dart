import 'package:flutter/material.dart';

extension ThemeDataApp on ThemeData {
/*  Color primaryColor50() {
    switch (this.primaryColor) {
      case pink:
        return pink50;
      case blue:
        return blue50;
      case purple:
        return purple50;
      default:
        return const Color(0xffe6f2f2);
    }
  }

  Color primaryColor100() {
    switch (this.primaryColor) {
      case pink:
        return pink100;
      case blue:
        return blue100;
      case purple:
        return purple100;
      default:
        return const Color(0xffb0d7d7);
    }
  }

  Color primaryColor200() {
    switch (this.primaryColor) {
      case pink:
        return pink200;
      case blue:
        return blue200;
      case purple:
        return purple200;
      default:
        return const Color(0xff8ac4c4);
    }
  }

  Color primaryColor300() {
    switch (this.primaryColor) {
      case pink:
        return pink300;
      case blue:
        return blue300;
      case purple:
        return purple300;
      default:
        return const Color(0xff55a9a9);
    }
  }

  Color primaryColor400() {
    switch (this.primaryColor) {
      case pink:
        return pink400;
      case blue:
        return blue400;
      case purple:
        return purple400;
      default:
        return const Color(0xff349899);
    }
  }

  Color primaryColor600() {
    switch (this.primaryColor) {
      case pink:
        return pink600;
      case blue:
        return blue600;
      case purple:
        return purple600;
      default:
        return const Color(0xff017374);
    }
  }

  Color primaryColor700() {
    switch (this.primaryColor) {
      case pink:
        return pink700;
      case blue:
        return blue700;
      case purple:
        return purple700;
      default:
        return const Color(0xff01595a);
    }
  }

  Color primaryColor800() {
    switch (this.primaryColor) {
      case pink:
        return pink800;
      case blue:
        return blue800;
      case purple:
        return purple800;
      default:
        return const Color(0xff014546);
    }
  }

  Color primaryColor900() {
    switch (this.primaryColor) {
      case pink:
        return pink900;
      case blue:
        return blue900;
      case purple:
        return purple900;
      default:
        return const Color(0xff014546);
    }
  }

*/

  Color white() {
    if (brightness == Brightness.light) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color black() {
    if (brightness == Brightness.light) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color descriptionColor() {
    if (brightness == Brightness.light) {
      return Colors.black38;
    } else {
      return Colors.white38;
    }
  }
}

const primaryColor50 = Color(0xfffff5e8);
const primaryColor100 = Color(0xffffe1b9);
const primaryColor200 = Color(0xffffd397);
const primaryColor300 = Color(0xffffbf67);
const primaryColor400 = Color(0xffffb249);
const primaryColor = Color(0xffff9f1c);
const primaryColor600 = Color(0xffe89119);
const primaryColor700 = Color(0xffb57114);
const primaryColor800 = Color(0xff8c570f);
const primaryColor900 = Color(0xff6b430c);

// const pink50 = Color(0xfffde9ef);
// const pink100 = Color(0xfff8b9cf);
// const pink200 = Color(0xfff598b7);
// const pink300 = Color(0xfff06896);
// const pink400 = Color(0xffed4b82);
// const pink = Color(0xffe91e63);
// const pink600 = Color(0xffd41b5a);
// const pink700 = Color(0xffa51546);
// const pink800 = Color(0xff801136);
// const pink900 = Color(0xff620d2a);
//
// const purple50 = Color(0xfff0ebf8);
// const purple100 = Color(0xffd0c2e9);
// const purple200 = Color(0xffb9a4de);
// const purple300 = Color(0xff997bcf);
// const purple400 = Color(0xff8561c5);
// const purple = Color(0xff673ab7);
// const purple600 = Color(0xff5e35a7);
// const purple700 = Color(0xff492982);
// const purple800 = Color(0xff392065);
// const purple900 = Color(0xff2b184d);
//
// const blue50 = Color(0xffeceef8);
// const blue100 = Color(0xffc3c9e8);
// const blue200 = Color(0xffa7afdd);
// const blue300 = Color(0xff7e8acd);
// const blue400 = Color(0xff6574c4);
// const blue = Color(0xff3f51b5);
// const blue600 = Color(0xff394aa5);
// const blue700 = Color(0xff2d3a81);
// const blue800 = Color(0xff232d64);
// const blue900 = Color(0xff1a224c);

//Secondary
const secondaryColor50 = Color(0xffeaf9f8);
const secondaryColor100 = Color(0xffbeede8);
const secondaryColor200 = Color(0xff9fe4dd);
const secondaryColor300 = Color(0xff73d7ce);
const secondaryColor400 = Color(0xff58d0c5);
const secondaryColor = Color(0xff2ec4b6);
const secondaryColor600 = Color(0xff2ab2a6);
const secondaryColor700 = Color(0xff218b81);
const secondaryColor800 = Color(0xff196c64);
const secondaryColor900 = Color(0xff13524c);

// //Tertiary
// const tertiaryColor50 = Color(0xfffffbe6);
// const tertiaryColor100 = Color(0xfffff3b0);
// const tertiaryColor200 = Color(0xffffed8a);
// const tertiaryColor300 = Color(0xffffe454);
// const tertiaryColor400 = Color(0xffffdf33);
// const tertiaryColor = Color(0xffffd700);
// const tertiaryColor600 = Color(0xffe8c400);
// const tertiaryColor700 = Color(0xffb59900);
// const tertiaryColor800 = Color(0xff8c7600);
// const tertiaryColor900 = Color(0xff6b5a00);

//Light
const lightColor50 = Color(0xfffcfcfc);
const lightColor100 = Color(0xfff6f6f6);
const lightColor200 = Color(0xfff2f2f1);
const lightColor300 = Color(0xffececeb);
const lightColor400 = Color(0xffe9e8e7);
const lightColor = Color(0xffe3e2e1);
const lightColor600 = Color(0xffcfcecd);
const lightColor700 = Color(0xffa1a0a0);
const lightColor800 = Color(0xff7d7c7c);
const lightColor900 = Color(0xff5f5f5f);

//Font
const fontColor50 = Color(0xffeaeae9);
const fontColor100 = Color(0xffbdbdbc);
const fontColor200 = Color(0xff9d9d9b);
const fontColor300 = Color(0xff70706e);
const fontColor400 = Color(0xff555451);
const fontColor = Color(0xff2a2926);
const fontColor600 = Color(0xff262523);
const fontColor700 = Color(0xff1e1d1b);
const fontColor800 = Color(0xff171715);
const fontColor900 = Color(0xff121110);

//Warning
const warningMain = Color(0xffFFC107);
const warningBackground = Color(0xffFFF9E7);
const warningFont = Color(0xffFF6F00);

//Success
const successMain = Color(0xff4CAF50);
const successBackground = Color(0xffEEF7EE);
const successFont = Color(0xff004D40);

//Error
const errorMain = Color(0xffF44336);
const errorBackground = Color(0xffFEEDEB);
const errorFont = Color(0xffB71C1C);

//Info
const infoMain = Color(0xff2196F3);
const infoBackground = Color(0xffE9F5FE);
const infoFont = Color(0xff0D47A1);

// //Gold Silver Bronze
// const goldColor = Color(0xffFFD700);
// const silverColor = Color(0xffCDCDCD);
// const bronzeColor = Color(0xffCD7F32);
