import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';

import '../widgets/membership_details_card.dart';
import '../widgets/success_header.dart';

class PaymentSuccessful extends StatelessWidget {
  final String membershipType;
  final String paymentMethod;
  final String startDate;
  final String expiryDate;

  const PaymentSuccessful({
    super.key,
    required this.membershipType,
    required this.paymentMethod,
    required this.startDate,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Success",
          style: TextStyles.headline.copyWith(color: AppColors.primaryGreen),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Success Header Section
              const SuccessHeader(
                title: 'Payment Successful',
                subtitle: 'Your membership has been activated\nsuccessfully',
              ),

              // Membership Details Card
              MembershipDetailsCard(
                membershipType: membershipType,
                paymentMethod: paymentMethod,
                startDate: startDate,
                expiryDate: expiryDate,
              ),

              const Gap(20),

              // Success Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: MainButton(
                  text: "Go to Home",
                  onPressed: () {
                    context.go(AppRoutes.mainApp);
                  },
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
