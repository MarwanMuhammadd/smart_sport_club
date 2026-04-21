import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/feature/home/data/dummy_data_carousel.dart';
import 'package:smart_sport_club/feature/home/data/services_data.dart';
import 'package:smart_sport_club/feature/home/widgets/carousel.dart';
import 'package:smart_sport_club/feature/home/widgets/event.dart';
import 'package:smart_sport_club/feature/home/widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// AppBar
      appBar: AppBar(
        //automaticallyImplyLeading :false,
        backgroundColor: const Color(0xFF0F2A22),
        elevation: 0,
        title: const Text(
          'Welcome to Smart Club',
          style: TextStyle(color: Colors.white),
        ),
      ),

      /// Body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230.h,
              child: BannerCarousel(banners: banners),
            ),

            SizedBox(height: 24.h),

            ServiceCard(itemData: servicesItemData),

            SizedBox(height: 32.h),

            

            LiveEventCard(),
          ],
        ),
      ),
    );
  }
}
