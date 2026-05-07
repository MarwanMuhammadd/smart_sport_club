import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';

Widget academyCard({
  required final List<Academy> academies,
}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: academies.length,
    itemBuilder: (context, index) {
      final academy = academies[index];
      return InkWell(
        onTap: () {
          context.push(AppRoutes.booking, extra: academy);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            image: DecorationImage(
              image: academy.imageUrl.startsWith('http')
                  ? NetworkImage(academy.imageUrl)
                  : AssetImage(academy.imageUrl) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  academy.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  academy.category,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
