import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/feature/home/data/dummy_data_carousel.dart';


class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});
  final List<DummyDataCarousel> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _index = 0;

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: widget.banners.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                
                  image: DecorationImage(
                    image: AssetImage(widget.banners[i].image),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.banners[i].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      widget.banners[i].subtitle,
                      style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        SizedBox(height: 8.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (i) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: _index == i ? 10.w : 8.w,
              height: _index == i ? 10.w : 8.w,
              decoration: BoxDecoration(
                color: _index == i ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
