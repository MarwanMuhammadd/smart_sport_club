import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';

extension VerticalSpacingExtension on num {
  SizedBox get H {
    return SizedBox(height: SizeConfig.getHeight(toDouble()));
  }
}

extension HorizontalSpacingExtension on num {
  SizedBox get W {
    return SizedBox(width: SizeConfig.getWidth(toDouble()));
  }
}

extension ResponsiveNum on num {
  double get h => SizeConfig.getHeight(toDouble());
  double get w => SizeConfig.getWidth(toDouble());
  double get sp => SizeConfig.getFontSize(toDouble());
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
