import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/home/data/services_data.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final List<ServicesData> itemData;

  const ServiceCard({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Our Services',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        SizedBox(height: 16.h),
        SizedBox(
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
                  color:Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurface
            : AppColors.darkTextPrimary,
                ),
                child: Column(
                  children: [
                    Icon(itemData[index].icon, color: Colors.green, size: 32.w),
                    SizedBox(height: 12.h),
                    Text(
                      itemData[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(double.infinity, 36.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                      ),
                      onPressed: () {
                        Navigations.pushTo(
                          context,
                          AppRoutes.serviceNotAvailable,
                        );
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
        ),
      ],
    );
  }
}
