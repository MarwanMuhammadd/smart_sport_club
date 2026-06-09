import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double screenWidth = 375;
  static double screenHeight = 812;
  static double blockHorizontal = 1.0;
  static double blockVertical = 1.0;

  static double _safeAreaHorizontal = 0.0;
  static double _safeAreaVertical = 0.0;
  static double safeBlockHorizontal = 1.0;
  static double safeBlockVertical = 1.0;

  // Base design dimensions (e.g. iPhone 13)
  static const double designWidth = 375;
  static const double designHeight = 812;

  void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    _mediaQueryData = mediaQueryData;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;

    // Scaling factors based on design
    blockHorizontal = screenWidth / designWidth;
    blockVertical = screenHeight / designHeight;

    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;

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
