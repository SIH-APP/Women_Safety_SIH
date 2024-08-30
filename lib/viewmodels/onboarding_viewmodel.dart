import '../models/onboarding_model.dart';

class OnboardingViewModel {
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      imagePath: 'assets/images/safety.png', // You will need to add these images to your assets
      title: 'Safety is our first priority',
      description: 'Empowering Women Everywhere: Your Safety, Our Priority. Navigate the World with Confidence and Security.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/tracking.png',
      title: 'Live tracking via cameras',
      description: 'Real-Time Protection: Live Tracking for Your Peace of Mind.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/digital.png',
      title: 'Your new asset is in the digital world.',
      description: 'Stay Informed, Stay Safe: Latest News and Updates for Empowered Living.',
    ),
  ];
}