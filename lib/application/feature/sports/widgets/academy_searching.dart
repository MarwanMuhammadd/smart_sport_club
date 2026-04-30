// import 'package:flutter/material.dart';
// import 'package:smart_sport_club/core/funcations/extensions.dart';
// import 'package:smart_sport_club/feature/sports/data/sports_data.dart';

// class AcademySearching extends StatefulWidget {
//   const AcademySearching({super.key, required this.onFiltered});

//   final Function(List<SportsData>) onFiltered;

//   @override
//   State<AcademySearching> createState() => _AcademySearchingState();
// }

// class _AcademySearchingState extends State<AcademySearching> {
//   late TextEditingController _searchController;

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//     _searchController.addListener(_filterSports);
//   }

//   void _filterSports() {
//     final query = _searchController.text;
//     List<SportsData> filtered;
//     if (query.isEmpty) {
//       filtered = sportData;
//     } else {
//       filtered = sportData
//           .where(
//             (sport) => sport.name.toLowerCase().contains(query.toLowerCase()),
//           )
//           .toList();
//     }
//     widget.onFiltered(filtered);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: TextFormField(
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: "Search sports academies",
//           hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
//           prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.w),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14.w),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 12.w,
//             vertical: 16.h,
//           ),
//         ),
//       ),
//     );
//   }
// }
