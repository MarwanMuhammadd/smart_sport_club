import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/feature/auth/widgets/header_part.dart';
import 'package:smart_sport_club/feature/auth/widgets/upper_part.dart';

class RequestPasswordScreen extends StatelessWidget {
  const RequestPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigations.pop(context);
          },
          child: Icon(Icons.chevron_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(children: [HeaderPart(), UpperPart()]),
        ),
      ),
    );
  }
}
