import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipekatbc/core/session/user_session.dart';
import 'package:sipekatbc/features/auth/data/auth_repository.dart';
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
      try {
        final profile = await AuthRepository().getProfile();
        UserSession.currentUser = profile;
      } catch (_) {
        // Ignore profile load errors on startup; routing can proceed.
      }
      return '/dashboard';
    }

    return '/login';
  }
}
