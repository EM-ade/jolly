import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_phone_screen.dart';
import '../../features/onboarding/presentation/onboarding_otp_screen.dart';
import '../../features/onboarding/presentation/onboarding_profile_screen.dart';
import '../../features/onboarding/presentation/onboarding_personalization_screen.dart';
import '../../features/onboarding/presentation/onboarding_avatar_screen.dart';
import '../../features/onboarding/presentation/subscription_screen.dart';
import '../../features/onboarding/presentation/subscription_plans_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/player/presentation/podcast_player_screen.dart';
import '../../features/podcast/data/models/podcast_models.dart';
import '../../core/animations/page_transitions.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const LoginScreen()),
    ),
    GoRoute(
      path: '/onboarding/phone',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const OnboardingPhoneScreen()),
    ),
    GoRoute(
      path: '/onboarding/otp',
      pageBuilder: (context, state) =>
          SlideTransitionPage(child: const OnboardingOtpScreen()),
    ),
    GoRoute(
      path: '/onboarding/profile',
      pageBuilder: (context, state) =>
          SlideTransitionPage(child: const OnboardingProfileScreen()),
    ),
    GoRoute(
      path: '/onboarding/personalization',
      pageBuilder: (context, state) =>
          SlideTransitionPage(child: const OnboardingPersonalizationScreen()),
    ),
    GoRoute(
      path: '/onboarding/avatar',
      pageBuilder: (context, state) =>
          SlideTransitionPage(child: const OnboardingAvatarScreen()),
    ),
    GoRoute(
      path: '/onboarding/subscription',
      pageBuilder: (context, state) =>
          SlideTransitionPage(child: const SubscriptionScreen()),
    ),
    GoRoute(
      path: '/onboarding/plans',
      pageBuilder: (context, state) =>
          SlideTransitionPage(child: const SubscriptionPlansScreen()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          FadeTransitionPage(child: const HomeScreen()),
    ),
    GoRoute(
      path: '/player/:episodeId',
      pageBuilder: (context, state) {
        final episodeId = int.parse(state.pathParameters['episodeId']!);
        return ModalTransitionPage(
          child: PodcastPlayerScreen(episodeId: episodeId),
        );
      },
    ),
  ],
);
