import 'package:flutter/material.dart';

class CustomStyle {
  static final BoxDecoration boxDecorationGradient = BoxDecoration(
    boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 3)],
    border: Border.all(color: Colors.black12),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.orange]),
  );

  static const TextStyle textStyleCardTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyleCardSubTitle = TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle textStyleTitleProfil = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontFamily: 'Roboto');

  static const TextStyle textStyleTitle = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline
  );
}
