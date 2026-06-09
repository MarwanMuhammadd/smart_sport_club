import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/local/shared_pref.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/home/data/model/banner_model.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});
  final List<BannerModel> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 200, // length of widget
            aspectRatio: 16 / 9,
            viewportFraction: 0.85, // slightly larger viewport fraction for a premium look
            initialPage: 0,
            enableInfiniteScroll: widget.banners.length > 1,
            reverse: false,
            autoPlay: widget.banners.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          itemCount: widget.banners.length,
          itemBuilder: (
            BuildContext context,
            int itemIndex,
            int pageViewIndex,
          ) {
            final banner = widget.banners[itemIndex];
            final token = SharedPref.getToken().trim();
            
            // Handle relative / absolute URLs correctly
            String imageUrl = banner.imageUrl ?? '';
            if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
              if (imageUrl.startsWith('/')) {
                imageUrl = '${Apis.baseUrl}$imageUrl';
              } else {
                imageUrl = '${Apis.baseUrl}/$imageUrl';
              }
            }
            log("Resolved Banner Image URL: $imageUrl");

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Network Image with loading and error states
                    imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            headers: token.isNotEmpty
                                ? {'Authorization': 'Bearer $token'}
                                : null,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[100],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    strokeWidth: 2.5,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to local asset if remote image fails/404s
                              String fallbackAsset = 'assets/images/Carousel Slide 1.png';
                              final bannerType = banner.type?.toLowerCase() ?? '';
                              if (bannerType.contains('gym')) {
                                fallbackAsset = 'assets/images/gym_offer.png';
                              } else if (bannerType.contains('swim')) {
                                fallbackAsset = 'assets/images/swimming_offer.png';
                              }
                              return Image.asset(
                                fallbackAsset,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/Carousel Slide 1.png',
                            fit: BoxFit.cover,
                          ),
                    // Dark Gradient Overlay for text readability
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Text Overlay
                    Positioned(
                      left: 16.w,
                      right: 16.w,
                      bottom: 16.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (banner.title != null && banner.title!.isNotEmpty)
                            Text(
                              banner.title!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (banner.subtitle != null && banner.subtitle!.isNotEmpty) ...[
                            SizedBox(height: 4.h),
                            Text(
                              banner.subtitle!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12.sp,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 12.h),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.banners.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.green,
            dotColor: Colors.black12,
          ),
        ),
      ],
    );
  }
}
