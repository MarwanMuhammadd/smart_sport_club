import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/application/feature/payment/data/renewal_plan_model.dart';

import '../widgets/continue_payment_button.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_methods_section.dart';

class Payment extends StatefulWidget {
  final RenewalPlan? plan;

  const Payment({super.key, this.plan});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String _selectedMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left_rounded),
        ),
        centerTitle: true,
        title: Text(
          "Payment Method",
          style: TextStyles.headline.copyWith(color: AppColors.primaryGreen),
        ),
      ),
      backgroundColor: const Color(0xFFF8F9FF),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                OrderSummaryCard(plan: widget.plan),
                PaymentMethodsSection(
                  onChanged: (method) {
                    setState(() {
                      _selectedMethod = method;
                    });
                  },
                ),
                ContinuePaymentButton(
                  plan: widget.plan?.title ?? 'N/A',
                  paymentMethod: _selectedMethod,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
