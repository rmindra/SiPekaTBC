import 'package:go_router/go_router.dart';
import 'package:sipekatbc/features/auth/presentation/pages/onboarding_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/login_page.dart';

GoRouter createRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ],
  );
}
