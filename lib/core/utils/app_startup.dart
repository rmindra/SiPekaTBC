import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipekatbc/service/supabase_client.dart';

class AppStartup {
  static Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();

    final onBoardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (!onBoardingCompleted) {
      return '/onboarding';
    }

    final session = supabase.auth.currentSession;

    if (session != null) {
      return '/dashboard';
    }

    return '/login';
  }
}
