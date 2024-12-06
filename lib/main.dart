import 'package:flutter/material.dart';
import 'package:quamin_health_module/routes/router.dart';
import 'package:quamin_health_module/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Health Tracker',
      theme: AppTheme.lightTheme, 
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}