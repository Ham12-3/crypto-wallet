import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const String _onboardingCompleteKey = 'onboarding_completed';

  /// Check if user has completed onboarding
  static Future<bool> isOnboardingComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardingCompleteKey) ?? false;
    } catch (e) {
      print('⚠️  OnboardingService: Failed to check onboarding status - $e');
      print('   Defaulting to show onboarding');
      return false; // Default to showing onboarding if there's an error
    }
  }

  /// Mark onboarding as completed
  static Future<void> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingCompleteKey, true);
    } catch (e) {
      print('⚠️  OnboardingService: Failed to save onboarding status - $e');
      // Silently fail - user will see onboarding again next time
    }
  }

  /// Reset onboarding status (useful for testing)
  static Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_onboardingCompleteKey);
    } catch (e) {
      print('⚠️  OnboardingService: Failed to reset onboarding - $e');
    }
  }
}
