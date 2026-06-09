import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/home/data/services_data.dart';
import 'package:smart_sport_club/application/feature/home/widgets/carousel.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/page/event.dart';
import 'package:smart_sport_club/application/feature/home/widgets/service_card.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/logic/events_cubit.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/logic/events_state.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/data/events_repository.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/widgets/events_empty_state.dart';
import 'package:smart_sport_club/application/feature/home/data/model/banner_model.dart';
import 'package:smart_sport_club/application/feature/home/data/repo/banner_repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<({List<BannerModel>? response, String? error})> _bannersFuture;

  @override
  void initState() {
    super.initState();
    _bannersFuture = BannerRepo.getBanners();
  }

  void _retryGetBanners() {
    setState(() {
      _bannersFuture = BannerRepo.getBanners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(EventsRepositoryImpl())..subscribeToEvents(),
      child: Scaffold(
        backgroundColor: Colors.white,

        /// AppBar
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: const Text(
            'Welcome to Smart Club',
            style: TextStyle(color: Colors.black),
          ),
        ),

        /// Body
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<({List<BannerModel>? response, String? error})>(
                future: _bannersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 255.h,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError || (snapshot.hasData && snapshot.data?.error != null)) {
                    final errorMsg = snapshot.data?.error ?? snapshot.error?.toString() ?? 'Failed to load banners';
                    return SizedBox(
                      height: 255.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errorMsg,
                              style: TextStyle(color: Colors.red, fontSize: 14.sp),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            ElevatedButton(
                              onPressed: _retryGetBanners,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final banners = snapshot.data?.response;
                  if (banners == null || banners.isEmpty) {
                    return SizedBox(
                      height: 255.h,
                      child: Center(
                        child: Text(
                          'No banners available',
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                      ),
                    );
                  }

                  return SizedBox(
                    height: 220.h,
                    child: BannerCarousel(banners: banners),
                  );
                },
              ),

              SizedBox(height: 24.h),

              ServiceCard(itemData: servicesItemData),

              SizedBox(height: 32.h),

              BlocBuilder<EventsCubit, EventsState>(
                builder: (context, state) {
                  if (state is EventsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF1ED760)),
                    );
                  }

                  if (state is EventsError) {
                    return Center(
                      child: Text(
                        'Failed to load events',
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    );
                  }

                  if (state is EventsLoaded) {
                    if (state.events.isEmpty) {
                      return const EventsEmptyState(
                        message: 'No Upcoming Events',
                        message1: 'New events will appear here once the admin adds them',
                        message2: 'Check back later for updates!',
                      );
                    }
                    
                    // Show ONLY the most recent ACTIVE one for now as requested
                    final activeEvent = state.events.first;
                    return LiveEventCard(event: activeEvent);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
