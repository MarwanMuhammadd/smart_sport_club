import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/home/data/dummy_data_carousel.dart';
import 'package:smart_sport_club/application/feature/home/data/services_data.dart';
import 'package:smart_sport_club/application/feature/home/widgets/carousel.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/page/event.dart';
import 'package:smart_sport_club/application/feature/home/widgets/service_card.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/logic/events_cubit.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/logic/events_state.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/data/events_repository.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/widgets/events_empty_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(EventsRepositoryImpl())..subscribeToEvents(),
      child: Scaffold(
        backgroundColor: Colors.white,

        /// AppBar
        appBar: AppBar(
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
                      return const EventsEmptyState();
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
