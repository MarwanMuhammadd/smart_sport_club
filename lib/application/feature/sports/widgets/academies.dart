import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/application/feature/sports/data/sports_data.dart';
import 'package:smart_sport_club/application/feature/sports/pages/booking_page.dart';

Widget academyCard({
  //required String image,
  required final List<SportsData> sportData,
}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: sportData.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          context.push(AppRoutes.booking, extra: sportData[index]);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            image: DecorationImage(
              image: AssetImage(sportData[index].imagePath),
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
                  sportData[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
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
