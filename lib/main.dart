// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/diet_module/diet_providers/cart_provider.dart';
import 'package:quamin_health_module/firebase_options.dart';
import 'package:quamin_health_module/router.dart';
import 'package:quamin_health_module/health_module/theme/app_theme.dart';
import 'health_module/providers/meal_provider.dart';
import 'package:firebase_core/firebase_core.dart';
  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e'); 
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        title: 'Health Tracker',
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
