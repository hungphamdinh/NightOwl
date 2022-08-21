import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };
  static const colorMain = '#283241';
  static const semiGray = '#D7DDE8';
  static const azure = '#648FCA';
  static const heather = '#BAC3D5';

  static const bgMain = '#F3F3F3';
  static const bgWhite = '#FFFFFF';
  static const bgHeather = '#BAC3D5';
  static const bgSemiGray = '#BABFC8';
  static const bgLightGray = '#D3D7D8';
  static const bgEC = '#283241';
  static const bgRed = '#FF361A';

  static const text = '#001335';
  static const textWhite = '#FFFFFF';
  static const textHeather = '#BAC3D5';
  static const textSemiGray = '#BABFC8';
  static const textBoldGrey = '#878787';

  static const statusHight = '#248EFF';
  static const statusVip = '#EC604D';
  static const statuslow = '#FDBC00';
  static const opacity = 'rgba(0, 0, 0, 0.4)';
  static const red = 'red';
  static const gray = 'gray';
  static const redOpacity = 'rgba(255, 0, 0, 0.2)';
  static const placeholder = '#9298A6';
  static const border = '#DFE0E3';
  static const black = "#0A0A0A";
  static const darkBlue = '#001335';
  static const yellow = "#FFE136";
  static const light = '#BABFC8';
  static const info = '#343D4D';
  static const primary = '#FFE136';
  static const topTab = '#D0A416';
  static const success = '#01C772';
  static const warning = 'orange';
  static const danger = 'red';
  static const dark = 'black';
  static const purple = 'purple';
  
}
extension HexToColor on String {
  Color hexToColor() {
    return Color(
        int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}