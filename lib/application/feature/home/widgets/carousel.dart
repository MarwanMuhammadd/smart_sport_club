import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/home/data/dummy_data_carousel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});
  final List<DummyDataCarousel> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 180, // length of widget
            aspectRatio: 16 / 9,
            viewportFraction: 0.8, // control in fraction selected item
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,

            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          itemCount: widget.banners.length,
          itemBuilder:
              (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) => ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.asset(
                  widget.banners[itemIndex].image,
                  fit: BoxFit
                      .cover, // you have to make the image cover to streach and takwe width
                  width: double.infinity,
                ),
              ),
        ),

        SizedBox(height: 8.h),

        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: banners.length,
          effect: ExpandingDotsEffect(dotHeight: 10, dotWidth: 10),
        ),
      ],
    );
  }
}
