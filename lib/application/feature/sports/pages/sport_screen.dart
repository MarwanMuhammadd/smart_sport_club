import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/academies.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Icon(Icons.sports_soccer, color: Colors.green, size: 24.w),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xff0A1A12),
        title: Text(
          "Elite Sports",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search sports academies",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20.w,
                    ),
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

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('academies').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No academies found.'));
                  }

                  final academies = snapshot.data!.docs.map((doc) {
                    return Academy.fromMap(doc.data() as Map<String, dynamic>, doc.id);
                  }).where((academy) {
                    return academy.name.toLowerCase().contains(_searchQuery) ||
                           academy.category.toLowerCase().contains(_searchQuery);
                  }).toList();

                  if (academies.isEmpty && _searchQuery.isNotEmpty) {
                    return const Center(child: Text('No matching academies found.'));
                  }

                  return academyCard(academies: academies);
                },
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
