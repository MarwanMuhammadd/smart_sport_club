import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
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
          onTap: () => context.pop(),
          child: Icon(Icons.chevron_left, size: 24.w),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: const SingleChildScrollView(
          child: Column(children: [HeaderPart(), UpperPart()]),
        ),
      ),
    );
  }
}
