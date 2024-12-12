// ignore_for_file: unused_import

import 'package:go_router/go_router.dart';
import 'package:quamin_health_module/choose_module/choose_options_screen.dart';
import 'package:quamin_health_module/diet_module/screens/diet_dasboard_screen.dart';
import 'package:quamin_health_module/startscreens/launch_screen.dart';
import 'package:quamin_health_module/startscreens/signin_screen.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/health_dashboard_screen.dart';
import 'package:quamin_health_module/startscreens/signup_screen.dart';

final router = GoRouter(
  initialLocation: '/',
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
      builder: (context, state) => SigninScreen(),
    ),
    GoRoute(
      path: '/health_dashboard',
      builder: (context, state) => const HealthDashboardScreen(),
    ),
    GoRoute(
      path: '/choose_module',
      builder: (context, state) => ChooseOptionsScreen(),
    ),
    GoRoute(
        path: '/diet_dashboard',
        builder: (context, state) => DietDashboardScreen())
  ],
);
