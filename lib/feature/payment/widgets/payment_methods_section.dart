import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

import 'payment_method_card.dart';

class PaymentMethodsSection extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const PaymentMethodsSection({super.key, required this.onChanged});

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection> {
  String _selectedMethod = 'Credit Card';

  void _onMethodSelected(String method) {
    setState(() {
      _selectedMethod = method;
    });
    widget.onChanged(method);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(
          'Select Payment Method',
          style: TextStyles.headline.copyWith(color: AppColors.primaryColor),
        ),
        PaymentMethodCard(
          title: 'Credit / Debit Card',
          isSelected: _selectedMethod == 'Credit Card',
          onTap: () => _onMethodSelected('Credit Card'),
        ),
        PaymentMethodCard(
          title: 'Mobile Wallet',
          subtitle: 'Vodafone Cash, Orange Money',
          isSelected: _selectedMethod == 'Mobile Wallet',
          onTap: () => _onMethodSelected('Mobile Wallet'),
        ),
        PaymentMethodCard(
          title: 'Pay at Club',
          subtitle: 'Complete payment at the club',
          isSelected: _selectedMethod == 'Pay at Club',
          onTap: () => _onMethodSelected('Pay at Club'),
        ),
      ],
    );
  }
}
