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

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  static void pushAndRemoveUntil(BuildContext context, Widget newScreen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => newScreen),
      (route) => false,
    );
  }
}


