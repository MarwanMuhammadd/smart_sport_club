import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/payment_method_chip.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              PaymentMethodChip(text: 'Cash'),
              PaymentMethodChip(
                text: 'Wallet',
                isSelected: true,
                icon: Icons.account_balance_wallet,
              ),
              PaymentMethodChip(text: 'Credit Card'),
            ],
          ),
        ),
      ],
    );
  }
}
