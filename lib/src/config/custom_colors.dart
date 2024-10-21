//custom colors com classe abstrata e acessar atributos
import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(25, 77, 189, .1),
  100: const Color.fromRGBO(25, 77, 189, .2),
  200: const Color.fromRGBO(25, 77, 189, .3),
  300: const Color.fromRGBO(25, 77, 189, .4),
  400: const Color.fromRGBO(25, 77, 189, .5),
  500: const Color.fromRGBO(25, 77, 189, .6),
  600: const Color.fromRGBO(25, 77, 189, .7),
  700: const Color.fromRGBO(25, 77, 189, .8),
  800: const Color.fromRGBO(25, 77, 189, .9),
  900: const Color.fromRGBO(25, 77, 189, 10)
};

abstract class CustomColors {
  static Color customContrastColor = const Color.fromARGB(255, 129, 12, 12);
  static Color forgetPassword = const Color.fromARGB(233, 57, 57, 57);

  static MaterialColor customSwatchColor =
      MaterialColor(0xFF8BC34A, _swatchOpacity);
}
