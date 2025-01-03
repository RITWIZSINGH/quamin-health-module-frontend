import 'package:flutter/material.dart';
import 'tabs/overview_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/sharing_tab.dart';
import '../../health_widgets/common/animated_page.dart';
import 'package:go_router/go_router.dart';

class HealthDashboardScreen extends StatefulWidget {
  const HealthDashboardScreen({super.key});

  @override
  State<HealthDashboardScreen> createState() => _HealthDashboardScreenState();
}

class _HealthDashboardScreenState extends State<HealthDashboardScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final _tabs = const [
    OverviewTab(),
    ExploreTab(),
    SharingTab(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavigationItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad, // Smoother easing curve
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,result) {
        if (didPop) return;
        context.go('/choose_module'); // Navigate back to ChooseOptionsScreen
      },
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const BouncingScrollPhysics().applyTo(
            const AlwaysScrollableScrollPhysics(),
          ),
          itemCount: _tabs.length,
          itemBuilder: (context, index) {
            return AnimatedPage(
              index: index,
              child: _tabs[index],
            );
          },
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onNavigationItemTapped,
          animationDuration: const Duration(milliseconds: 300),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Overview',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.share_outlined),
              selectedIcon: Icon(Icons.share),
              label: 'Sharing',
            ),
          ],
        ),
      ),
    );
  }
}
