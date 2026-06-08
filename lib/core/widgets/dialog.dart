import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        Center(child: CircularProgressIndicator(color: Colors.white),),
  );
}
