import 'package:go_router/go_router.dart';

// --- AUTH PAGES ---
import 'package:sipekatbc/features/auth/presentation/pages/onboarding_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/login_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/register_page.dart';
import 'package:sipekatbc/features/auth/presentation/pages/reset_password_page.dart';

// --- MAIN PAGES ---
import 'package:sipekatbc/features/home/presentation/pages/home_page.dart';
import 'package:sipekatbc/features/profile/presentation/pages/profile_page.dart';

// --- EDUCATION PAGES ---
import 'package:sipekatbc/features/education/presentation/pages/education_page.dart';
import 'package:sipekatbc/features/education/presentation/pages/article_detail_page.dart';
import 'package:sipekatbc/features/education/presentation/pages/create_article_page.dart';

import 'package:sipekatbc/features/maps/presentasion/pages/maps_page.dart';
import 'package:sipekatbc/features/profile/presentation/pages/riwayat_bacaan_page.dart';
import 'package:sipekatbc/features/profile/presentation/pages/tentang_sipekatbc_page.dart';
import 'package:sipekatbc/features/profile/presentation/pages/terms_conditions_page.dart';

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
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/education',
        builder: (context, state) => const EducationPage(),
      ),
      GoRoute(
        path: '/article-detail/:id',
        builder: (context, state) {
          final articleId = state.pathParameters['id'] ?? '';
          return ArticleDetailPage(articleId: articleId);
        },
      ),
      GoRoute(
        path: '/create-article',
        builder: (context, state) => const CreateArticlePage(),
      ),
      GoRoute(path: '/maps', builder: (context, state) => const MapsPage()),
      GoRoute(
        path: '/riwayat',
        builder: (context, state) => RiwayatBacaanPage(),
      ),
      GoRoute(
        path: '/tentang',
        builder: (context, state) => TentangSipekatbcPage(),
      ),
      GoRoute(path: '/tnc', builder: (context, state) => TermsConditionsPage()),
    ],
  );
}
