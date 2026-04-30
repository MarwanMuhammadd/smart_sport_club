import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';

class ResponsiveCenterWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const ResponsiveCenterWrapper({
    super.key,
    required this.child,
    this.maxWidth = 500,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? maxWidth : double.infinity,
              ),
              child: Padding(
                padding: padding ?? EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40 : 20,
                  vertical: 20,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
