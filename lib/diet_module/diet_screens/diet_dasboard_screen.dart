import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'tabs/diet_tracker_tab.dart';
import 'tabs/order_items_tab.dart';
import 'tabs/track_order_tab.dart';
import 'tabs/generate_plan_tab.dart';
import '/health_module/widgets/common/animated_page.dart';

class DietDashboardScreen extends StatefulWidget {
  const DietDashboardScreen({super.key});

  @override
  State<DietDashboardScreen> createState() => _DietDashboardScreenState();
}

class _DietDashboardScreenState extends State<DietDashboardScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final _tabs = const [
    DietTrackerTab(),
    OrderItemsTab(),
    TrackOrderTab(),
    GeneratePlanTab(),
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
      curve: Curves.easeOutQuad,
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
              icon: Icon(Icons.track_changes_outlined),
              selectedIcon: Icon(Icons.track_changes),
              label: 'Track Diet',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'Order',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_shipping_outlined),
              selectedIcon: Icon(Icons.local_shipping),
              label: 'Track Order',
            ),
            NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined),
              selectedIcon: Icon(Icons.auto_awesome),
              label: 'Generate Plan',
            ),
          ],
        ),
      ),
    );
  }
}