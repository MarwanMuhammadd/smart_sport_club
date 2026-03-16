import 'package:flutter/material.dart';

extension VerticalSpacingExtension on num {
  SizedBox get H {
    return SizedBox(height: toDouble());
  }
}

extension HorizontalSpacingExtension on num {
  SizedBox get W {
    return SizedBox(width: toDouble());
  }
}

extension PushExtension on BuildContext {
  void pushTo(Widget newScreen) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => newScreen));
  }
}

extension PushReplacementExtension on BuildContext {
  void pushReplacement(Widget newScreen) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => newScreen),
    );
  }
}
