import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/feature/sports/data/sports_data.dart';
import 'package:smart_sport_club/feature/sports/widgets/academies.dart';


class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SportsData> _filteredSportData = sportData;

  void _filterSports(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSportData = sportData;
      } else {
        _filteredSportData = sportData
            .where(
              (sport) => sport.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// Top Bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.sports_soccer, color: Colors.green, size: 24.w),
            SizedBox(width: 8.w),
            Text(
              "Elite Sports",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              radius: 18.w,
              child: Icon(Icons.person, color: Colors.white, size: 20.w),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              /// Search
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: _filterSports,
                  decoration: InputDecoration(
                    hintText: "Search sports academies",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.w),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.w),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 16.h,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Featured Academies",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              academyCard(sportData: _filteredSportData),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
