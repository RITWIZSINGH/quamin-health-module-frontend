// ignore_for_file: unused_import

import 'package:go_router/go_router.dart';
import 'package:quamin_health_module/screens/startscreens/launch_screen.dart';
import 'package:quamin_health_module/screens/startscreens/signin_screen.dart';
import 'package:quamin_health_module/screens/dashboard/dashboard_screen.dart';
import 'package:quamin_health_module/screens/startscreens/signup_screen.dart';

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
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
