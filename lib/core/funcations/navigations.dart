import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigations {
  /// Push a new named route using GoRouter
  static void pushTo(BuildContext context, String routePath, {Object? extra}) {
    context.push(routePath, extra: extra);
  }

  /// Replace current route with a new one using GoRouter
  static void pushReplacement(
    BuildContext context,
    String routePath, {
    Object? extra,
  }) {
    context.pushReplacement(routePath, extra: extra);
  }

  /// Go back to previous page using GoRouter
  static void pop(BuildContext context) {
    context.pop();
  }

  void pushToBase(BuildContext context, String routeName) {
    context.go(routeName);
  }
}
