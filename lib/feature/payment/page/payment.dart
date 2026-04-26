import 'package:flutter/material.dart';

import '../widgets/continue_payment_button.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_methods_section.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: ListView(
        children: [
          const PaymentHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                const OrderSummaryCard(),
                const PaymentMethodsSection(),
                const ContinuePaymentButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
