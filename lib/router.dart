import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/choose_module/choose_options_screen.dart';
import 'package:quamin_health_module/diet_module/diet_screens/diet_dasboard_screen.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/health_dashboard_screen.dart';
import 'package:quamin_health_module/startscreens/launch_screen.dart';
import 'package:quamin_health_module/startscreens/services/auth_notifier.dart';
import 'package:quamin_health_module/startscreens/signin_screen.dart';
import 'package:quamin_health_module/startscreens/signup_screen.dart';

import 'package:flutter/material.dart';

class AppRouter {
  final AuthNotifier authNotifier;

  AppRouter(this.authNotifier);

  late final GoRouter router = GoRouter(
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuthenticated = authNotifier.isAuthenticated;
      final isSignInRoute = state.matchedLocation == '/signin';
      final isSignUpRoute = state.matchedLocation == '/signup';
      final isLaunchRoute = state.matchedLocation == '/';

      if (isAuthenticated && (isSignInRoute || isSignUpRoute || isLaunchRoute)) {
        return '/choose_module';
      }

      if (!isAuthenticated && 
          !(isSignInRoute || isSignUpRoute || isLaunchRoute)) {
        return '/signin';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LaunchScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SigninScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return PopScope(
            canPop: !authNotifier.isAuthenticated,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/choose_module',
            builder: (context, state) => const ChooseOptionsScreen(),
          ),
          GoRoute(
            path: '/health_dashboard',
            builder: (context, state) => const HealthDashboardScreen(),
          ),
          GoRoute(
            path: '/diet_dashboard',
            builder: (context, state) => const DietDashboardScreen(),
          ),
        ],
      ),
    ],
  );
}