import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/option_card.dart';
import 'utils/app_colors.dart';
import 'utils/app_styles.dart';

class ChooseOptionsScreen extends StatelessWidget {
  const ChooseOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Welcome back 👋',
                style: AppStyles.headingStyle,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    OptionCard(
                      title: 'Health Module',
                      svgPath: 'assets/icons/health.png',
                      onTap: () {
                        context.go('/dashboard');
                      },
                    ),
                    OptionCard(
                      title: 'Diet Plan',
                      svgPath: 'assets/icons/diet.png',
                      onTap: () {
                        // Navigate to diet plan
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}