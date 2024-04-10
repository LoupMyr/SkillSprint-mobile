import 'package:flutter/material.dart';

class CustomStyle {
  static final BoxDecoration boxDecorationGradient = BoxDecoration(
    boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 3)],
    border: Border.all(color: Colors.black12),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.orange]),
  );

  static const TextStyle textStyleCardTitle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyleCardSubTitle = TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}
