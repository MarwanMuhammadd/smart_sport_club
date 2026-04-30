import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/application/feature/payment/data/renewal_plan_model.dart';
import 'package:smart_sport_club/application/feature/payment/renew_membership/widgets/renewal_plan_card.dart';

class RenewalPlansSelector extends StatefulWidget {
  const RenewalPlansSelector({super.key});

  @override
  State<RenewalPlansSelector> createState() => _RenewalPlansSelectorState();
}

class _RenewalPlansSelectorState extends State<RenewalPlansSelector> {
  int _selectedPlanIndex = 1; // Default to the 1-year plan

  RenewalPlan getSelectedPlan() {
    final plan = _plans[_selectedPlanIndex];
    return RenewalPlan(
      title: plan['title'],
      price: plan['priceValue'],
      description: 'Full Club Access',
    );
  }

  final List<Map<String, dynamic>> _plans = [
    {
      'title': '6 Months',
      'subtitle': 'Best for short-term\ncommitment',
      'price': '1,200\nEGP',
      'priceValue': '1,200 EGP',
      'isBestValue': false,
    },
    {
      'title': '1 Year',
      'subtitle': 'Save more with yearly\nplan',
      'price': '2,000\nEGP',
      'priceValue': '2,000 EGP',
      'isBestValue': true,
      'discountText': 'SAVE 400 EGP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select your renewal plan', style: TextStyles.title),
        4.H,
        Text(
          'Choose the duration that fits your training \nschedule.',
          style: TextStyles.caption1.copyWith(color: const Color(0xFF7C8C7C)),
        ),
        24.H,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _plans.length,
          separatorBuilder: (context, index) => 16.H,
          itemBuilder: (context, index) {
            final plan = _plans[index];
            return RenewalPlanCard(
              title: plan['title'],
              subtitle: plan['subtitle'],
              price: plan['price'],
              isBestValue: plan['isBestValue'],
              discountText: plan['discountText'],
              isSelected: _selectedPlanIndex == index,
              onTap: () {
                setState(() {
                  _selectedPlanIndex = index;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
