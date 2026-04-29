import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/payment/logic/payment_cubit.dart';
import 'package:smart_sport_club/feature/payment/logic/payment_state.dart';

void showConfirmSubscriptionBottomSheet({
  required BuildContext context,
  required String plan,
  required String paymentMethod,
  required VoidCallback onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BlocProvider(
      create: (context) => PaymentCubit(),
      child: ConfirmSubscriptionBottomSheet(
        plan: plan,
        paymentMethod: paymentMethod,
        onConfirm: onConfirm,
      ),
    ),
  );
}

class ConfirmSubscriptionBottomSheet extends StatelessWidget {
  final String plan;
  final String paymentMethod;
  final VoidCallback onConfirm;

  const ConfirmSubscriptionBottomSheet({
    super.key,
    required this.plan,
    required this.paymentMethod,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.pop(context); // Close bottom sheet
          onConfirm(); // Navigate to success page
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.w),
              topRight: Radius.circular(24.w),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryText.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              24.H,
              Text(
                'Confirm Subscription',
                style: TextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
              8.H,
              Text(
                'Please review your details before continuing',
                style: TextStyles.caption1.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              24.H,

              // Details Section
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.accentPrimaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.w),
                  border: Border.all(
                    color: AppColors.accentPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.calendar_today_rounded,
                      label: 'Plan',
                      value: plan,
                    ),
                    Divider(
                      height: 32.h,
                      color: AppColors.accentPrimaryColor,
                    ),
                    _buildDetailRow(
                      icon: Icons.payment_rounded,
                      label: 'Payment Method',
                      value: paymentMethod,
                    ),
                  ],
                ),
              ),
              24.H,

              // Confirmation Message
              Center(
                child: Text(
                  'Are you sure you want to proceed with this subscription?',
                  textAlign: TextAlign.center,
                  style: TextStyles.body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              32.H,

              // Actions
              MainButton(
                text: 'Yes, Confirm',
                isLoading: state is PaymentLoading,
                onPressed: () {
                  context.read<PaymentCubit>().confirmSubscription();
                },
              ),
              12.H,
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: TextButton(
                  onPressed: state is PaymentLoading 
                      ? null 
                      : () => Navigator.pop(context),
                  child: Text(
                    'No, Cancel',
                    style: TextStyles.body.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryGreen,
            size: 20.w,
          ),
        ),
        16.W,
        Text(
          label,
          style: TextStyles.caption1.copyWith(
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyles.body.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
