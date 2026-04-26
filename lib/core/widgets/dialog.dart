import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        Center(child: Lottie.asset(AppImages.notificationJson)),
  );
}
