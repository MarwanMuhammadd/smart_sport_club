import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class TrainingBookingCard extends StatelessWidget {
  const TrainingBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF4F4F5),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A0A1A12),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TRAINING BOOKINGS',
                style: TextStyle(
                  color: Color(0xFF71717A),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  letterSpacing: 0.65,
                ),
              ),
              const SizedBox(height: 8),
              // Live count from Firestore 'activities' collection
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('activities')
                    .snapshots(),
                builder: (context, snapshot) {
                  final count = snapshot.hasData
                      ? snapshot.data!.docs.length.toString()
                      : '0';

                  return Text(
                    count,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const ShapeDecoration(
              color: Color(0x191AD55F),
              shape: CircleBorder(),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}
