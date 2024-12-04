import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quamin_health_module/screens/launch_screen.dart';
import 'package:quamin_health_module/screens/signup_screen.dart';
import 'package:quamin_health_module/screens/dashboard/dashboard_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LaunchScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);