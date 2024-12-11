// ignore_for_file: unused_import

import 'package:go_router/go_router.dart';
import 'package:quamin_health_module/choose_module/choose_options_screen.dart';
import 'package:quamin_health_module/startscreens/launch_screen.dart';
import 'package:quamin_health_module/startscreens/signin_screen.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/dashboard_screen.dart';
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
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/choose_module',
      builder: (context, state) => ChooseOptionsScreen(),
    )
  ],
);
