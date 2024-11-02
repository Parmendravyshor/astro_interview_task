import 'package:eco/domain/models/dashboard_model.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedCategory = 'All'.obs;

  // Sample astrologer list
  final astrologers = <Astrologer>[
    Astrologer(
        name: 'Astro A',
        specialization: 'Numerology',
        cost: 'र15/min',
        rating: 1,
        verified: true,
        type: 'Finance'),
    Astrologer(
        name: 'Astro B',
        specialization: 'Vedic Astrology',
        cost: 'र17/min',
        type: 'Business',
        rating: 2,
        verified: false),
    Astrologer(
        name: 'Astro C',
        specialization: 'Tarot Reading',
        cost: 'र18/min',
        type: 'Education',
        rating: 3,
        verified: true),
    // Add more astrologers as needed...
  ].obs;

  // Filter the list based on the selected category using 'type' instead of 'specialization'
  List<Astrologer> get filteredAstrologers {
    if (selectedCategory.value == 'All') {
      return astrologers;
    }
    return astrologers
        .where((astro) => astro.type == selectedCategory.value)
        .toList();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}
