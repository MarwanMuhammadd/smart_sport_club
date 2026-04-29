import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/payment/renew_membership/widgets/membership_card.dart';
import 'package:smart_sport_club/feature/payment/renew_membership/widgets/renewal_plans_selector.dart';

class RenewMembershipPage extends StatefulWidget {
  const RenewMembershipPage({super.key});

  @override
  State<RenewMembershipPage> createState() => _RenewMembershipPageState();
}

class _RenewMembershipPageState extends State<RenewMembershipPage> {
  final _planSelectorKey = GlobalKey<State<RenewalPlansSelector>>();

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
            RenewalPlansSelector(key: _planSelectorKey),
            32.H,
            MainButton(
              text: "Continue to payment",
              onPressed: () {
                // Get the selected plan from RenewalPlansSelector
                final selectorState = _planSelectorKey.currentState;
                if (selectorState != null) {
                  final selectedPlan = (selectorState as dynamic)
                      .getSelectedPlan();
                  if (selectedPlan != null) {
                    // Navigate to payment page with the selected plan
                    Navigations.pushTo(
                      context,
                      AppRoutes.payment,
                      extra: selectedPlan,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
