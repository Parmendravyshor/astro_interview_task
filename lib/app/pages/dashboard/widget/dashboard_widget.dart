import 'package:eco/app/pages/dashboard/dashboard_controller.dart';
import 'package:eco/domain/models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardWidget extends StatelessWidget {
  final List<String> categories = [
    'All',
    'Finance',
    'Business',
    'Education',
    'Legal'
  ];

  DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(
                        () => ChoiceChip(
                          label: Text(category),
                          selected:
                              controller.selectedCategory.value == category,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          selectedColor: Colors.amber,
                          labelStyle: TextStyle(
                            color: controller.selectedCategory.value == category
                                ? Colors.black87
                                : Colors.white70,
                          ),
                          onSelected: (bool selected) {
                            controller.selectCategory(category);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.filteredAstrologers.length,
                  itemBuilder: (context, index) {
                    final astrologer = controller.filteredAstrologers[index];
                    return AstrologerCard(astrologer: astrologer);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class AstrologerCard extends StatelessWidget {
  final Astrologer astrologer;

  const AstrologerCard({super.key, required this.astrologer});
  List<Widget> buildRatingStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        // Filled star
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 16));
      } else if (i - rating <= 0.5) {
        // Half-filled star for ratings like 4.5
        stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 16));
      } else {
        // Empty star
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 16));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("asset/images/4.jpg"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        astrologer.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      if (astrologer.verified)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.verified,
                            color: Colors.blueAccent,
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    astrologer.specialization,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    astrologer.cost,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                  ),
                  Row(
                    children: buildRatingStars(astrologer.rating.toDouble()),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Chat functionality here
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Chat',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
