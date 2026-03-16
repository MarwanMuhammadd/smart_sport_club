import 'package:flutter/material.dart';

class Navigations {
  static void pushTo(BuildContext context, Widget newScreen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => newScreen));
  }

  static void pushReplacement(BuildContext context, Widget newScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}


