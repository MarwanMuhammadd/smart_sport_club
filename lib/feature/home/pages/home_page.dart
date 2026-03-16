import 'package:flutter/material.dart';
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
        actions: const [
          SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.green),
          ),
          SizedBox(width: 12),
        ],
      ),

      /// Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 230, child: BannerCarousel(banners: banners)),

            const SizedBox(height: 24),

            /// ======================
            /// Our Services
            /// ======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Our Services',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('See All', style: TextStyle(color: Colors.green)),
              ],
            ),

            const SizedBox(height: 16),

            ServiceCard(itemData: servicesItemData),

            const SizedBox(height: 32),

            /// ======================
            /// Monthly Highlight
            /// ======================
            const Text(
              'Monthly Highlight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            LiveEventCard(),
          ],
        ),
      ),
    );
  }
}
