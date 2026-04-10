import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockHorizontal;
  static late double blockVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  // Base design dimensions (e.g. iPhone 13)
  static const double designWidth = 375;
  static const double designHeight = 812;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    // Scaling factors based on design
    blockHorizontal = screenWidth / designWidth;
    blockVertical = screenHeight / designHeight;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / designWidth;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / designHeight;
  }

  // Get responsive width
  static double getWidth(double inputWidth) {
    return inputWidth * blockHorizontal;
  }

  // Get responsive height
  static double getHeight(double inputHeight) {
    return inputHeight * blockVertical;
  }

  // Get responsive font size
  static double getFontSize(double inputSize) {
    // Usually font size scales best with width to prevent weird gaps
    return inputSize * blockHorizontal;
  }
}
