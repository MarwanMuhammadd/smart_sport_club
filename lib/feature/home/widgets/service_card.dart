import 'package:flutter/material.dart';
import 'package:smart_sport_club/feature/home/data/services_data.dart';

class ServiceCard extends StatelessWidget {
  final List<ServicesData> itemData;

  const ServiceCard({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.22, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemData.length,
        itemBuilder: (context, index) {
          return Container(
            width:
                MediaQuery.of(context).size.height *
                0.23, // Fixed width for each card
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
            ),
            child: Column(
              children: [
                Icon(itemData[index].icon, color: Colors.green, size: 32),
                const SizedBox(height: 12),
                Text(
                  itemData[index].title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F2A22),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Explore',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
