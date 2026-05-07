import 'package:go_router/go_router.dart';
import 'package:sipekatbc/features/auth/presentation/pages/onboarding_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/login_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/register_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/reset_password_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/education/presentation/pages/education_page.dart';

GoRouter createRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context,state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/education',
        builder: (context, state) => const EducationPage(),
      ),
    ],
  );
}
