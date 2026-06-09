
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/application/feature/home/widgets/event/widgets/events_empty_state.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/academies.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart' as new_api_model;
import 'package:smart_sport_club/application/feature/sports/data/repo/academy_repo.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<new_api_model.AcademyModel>? _academies;
  String? _errorMessage;
  bool _isFirstLoad = true;
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    _loadData();
    // Poll the API every 4 seconds to sync data automatically
    _syncTimer = Timer.periodic(const Duration(seconds: 4), (_) => _loadData(isSilent: true));
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData({bool isSilent = false}) async {
    if (isSilent && !mounted) return;
    
    if (!isSilent) {
      setState(() {
        _isFirstLoad = true;
        _errorMessage = null;
      });
    }

    try {
      final result = await AcademyRepo.getAcademies();
      if (mounted) {
        setState(() {
          _isFirstLoad = false;
          if (result.response != null) {
            _academies = result.response;
            _errorMessage = null;
          } else {
            if (_academies == null) {
              _errorMessage = result.error ?? 'Failed to load academies';
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFirstLoad = false;
          if (_academies == null) {
            _errorMessage = e.toString();
          }
        });
      }
    }
  }

  Widget _buildAcademiesContent() {
    if (_isFirstLoad && _academies == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.green));
    }
    
    if (_errorMessage != null && _academies == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () => _loadData(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final apiAcademies = _academies;
    if (apiAcademies == null || apiAcademies.isEmpty) {
      return const EventsEmptyState(
        message: 'No academies found',
        message1: 'Try adjusting your search',
        message2: 'No results available',
      );
    }

    final academies = apiAcademies.map((apiModel) {
      String imgUrl = apiModel.imageUrl ?? '';
      if (imgUrl.isNotEmpty && !imgUrl.startsWith('http')) {
        if (imgUrl.startsWith('/')) {
          imgUrl = '${Apis.baseUrl}$imgUrl';
        } else {
          imgUrl = '${Apis.baseUrl}/$imgUrl';
        }
      }

      return Academy(
        academyId: apiModel.id?.toString() ?? '',
        name: apiModel.name ?? '',
        category: apiModel.description ?? '',
        isActive: apiModel.isActive ?? true,
        imageUrl: imgUrl,
      );
    }).where((academy) {
      return academy.name.toLowerCase().contains(_searchQuery) ||
             academy.category.toLowerCase().contains(_searchQuery);
    }).toList();

    if (academies.isEmpty && _searchQuery.isNotEmpty) {
      return const Center(child: Text('No matching academies found.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        academyCard(academies: academies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// Top Bar
      appBar: AppBar(
        
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.green,
        title: Text(
          "Academies",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () => _loadData(),
        color: Colors.green,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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

                _buildAcademiesContent(),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
