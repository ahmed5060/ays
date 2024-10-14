import 'package:flutter/material.dart';

class AppColors {
  static const Color blueColor1 = Color(0xff254f5a); //#56151D //AF111F

  static const Color blueColor2 = Color(0xff52939a);
  static const Color greyColor1 = Color(0xffAFB1B6);
  static const Color greyColor2 = Colors.grey;
  static const Color whiteColor = Colors.white;
  static const Color white24Color = Colors.white24;
  static const Color white38Color = Colors.white38;
  static const Color white70Color = Colors.white70;
  static const Color blackColor = Colors.black;
  static const Color black12Color = Colors.black12;
  static const Color black38Color = Colors.black38;
  static const Color black87Color = Colors.black87;
  static const Color yellowColor = Colors.yellow;
  static const Color greenColor = Color(0xff00CC99);
  static const Color redColor = Color(0xffEB5757);

  static Map<int, Color> materialColorMap = {
    50: const Color.fromRGBO(127, 72, 170, .1),
    100: const Color.fromRGBO(127, 72, 170, .2),
    200: const Color.fromRGBO(127, 72, 170, .3),
    300: const Color.fromRGBO(127, 72, 170, .4),
    400: const Color.fromRGBO(127, 72, 170, .5),
    500: const Color.fromRGBO(127, 72, 170, .6),
    600: const Color.fromRGBO(127, 72, 170, .7),
    700: const Color.fromRGBO(127, 72, 170, .8),
    800: const Color.fromRGBO(127, 72, 170, .9),
    900: const Color.fromRGBO(127, 72, 170, 1),
  };

  static MaterialColor baseColor = MaterialColor(
    0xff7f48aa,
    materialColorMap,
  );
}
