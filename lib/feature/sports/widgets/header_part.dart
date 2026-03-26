import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/feature/sports/data/coach_data.dart';

class CircleImage extends StatefulWidget {
  const CircleImage({super.key, required this.coachData});

  final List<CoachData> coachData;

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.coachData.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        widget.coachData[index].imagePath,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.coachData[index].name,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                20.W,
              ],
            ),
          );
        },
      ),
    );
  }
}
