import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/feature/home/data/services_data.dart';

class ServiceCard extends StatelessWidget {
  final List<ServicesData> itemData;

  const ServiceCard({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemData.length,
        itemBuilder: (context, index) {
          return Container(
            width: 180.w,
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: Colors.grey.shade100,
            ),
            child: Column(
              children: [
                Icon(itemData[index].icon, color: Colors.green, size: 32.w),
                SizedBox(height: 12.h),
                Text(
                  itemData[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F2A22),
                    minimumSize: Size(double.infinity, 36.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                  ),
                  onPressed: () {
                    context.push(AppRoutes.bookingSummary);
                  },
                  child: Text(
                    'Explore',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
