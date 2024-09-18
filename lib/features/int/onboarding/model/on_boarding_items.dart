import '../../../../core/utils/constant/app_assets.dart';
import 'onboarding_items.dart';

List<Map<String, dynamic>> _onboardingItems = [
  {
    "title": "Book Your Trip",
    "desc":
        "Swipe, Match, Connect - Discover your ideal partner for long term relationship, coffee dates, or more.",
    "imagePath": AppAssets.onboarding1
  },
  {
    "title": "Driver Pick up on your way",
    "desc":
        "Browse through diverse profiles and find individuals who match your preferences",
    "imagePath": AppAssets.onboarding2
  },
  {
    "title": "Street Pickup",
    "desc":
        "Break the ice and have meaningful conversations with like-minded people.",
    "imagePath": AppAssets.onboarding3
  },
  {
    "title": "Embrace Memorable Experiences",
    "desc":
        "Create unforgettable memories with extraordinary people who share your interests.",
    "imagePath": AppAssets.onboarding4
  },
];

List<OnboardingItems> onboardingItems =
    _onboardingItems.map((item) => OnboardingItems.getItems(item)).toList();
