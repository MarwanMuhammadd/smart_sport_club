import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/profile/renew_membership/widgets/membership_card.dart';
import 'package:smart_sport_club/feature/profile/renew_membership/widgets/renewal_plans_selector.dart';
 


class RenewMembershipPage extends StatelessWidget {
  const RenewMembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.chevron_left_rounded, size: 30.w),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          "Renew Membership",
          style: TextStyles.title.copyWith(color: AppColors.primaryGreen),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(
          20, //TODO: we need to handle it
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MembershipCard(
              title: 'Renew Membership',
              icon: Icons.verified,
              baseColor: AppColors.primaryGreen,
              // onViewDetails: () {},
            ),
            32.H,
            const RenewalPlansSelector(),
            32.H,
            MainButton(
              text: "Continue to payment",
              onPressed: () {
                Navigations.pushTo(context, AppRoutes.payment);
              },
            ),
          ],
        ),
      ),
    );
  }
}
