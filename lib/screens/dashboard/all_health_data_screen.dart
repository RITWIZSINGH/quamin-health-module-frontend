import 'package:flutter/material.dart';
import 'package:quamin_health_module/routes/custom_page_route.dart';
import '../../widgets/all_healthData_widgets/health_data_item.dart';
import 'highlightscreens/cycle_tracking_screen.dart';
import 'highlightscreens/nutrition_tracker_screens/nutrition_screen.dart';
import 'highlightscreens/sleep_screen.dart';
import 'highlightscreens/steps_screen.dart';

class AllHealthDataScreen extends StatelessWidget {
  const AllHealthDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: sw / 9),
          child: const Text(
            'All Health Data',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          HealthDataItem(
            icon: Icons.track_changes,
            color: Colors.blue,
            title: 'Double Support Time',
            value: '29.7%',
            onTap: () {},
          ),
          HealthDataItem(
            icon: Icons.directions_walk,
            color: Colors.purple,
            title: 'Steps',
            value: '11,875 steps',
            onTap: () => Navigator.push(
              context,
              CustomPageRoute(child: const StepsScreen()),
            ),
          ),
          HealthDataItem(
            icon: Icons.calendar_today,
            color: Colors.pink,
            title: 'Cycle tracking',
            value: '08 April',
            onTap: () => Navigator.push(
              context,
              CustomPageRoute(child: const CycleTrackingScreen()),
            ),
          ),
          HealthDataItem(
            icon: Icons.bedtime,
            color: Colors.orange,
            title: 'Sleep',
            value: '7 hr 31 min',
            onTap: () => Navigator.push(
              context,
              CustomPageRoute(child: const SleepScreen()),
            ),
          ),
          HealthDataItem(
            icon: Icons.favorite,
            color: Colors.red,
            title: 'Heart',
            value: '68 BPM',
            onTap: () {},
          ),
          HealthDataItem(
            icon: Icons.local_fire_department,
            color: Colors.teal,
            title: 'Burned calories',
            value: '850 kcal',
            onTap: () => Navigator.push(
              context,
              CustomPageRoute(child: const NutritionScreen()),
            ),
          ),
          HealthDataItem(
            icon: Icons.monitor_weight,
            color: Colors.indigo,
            title: 'Body mass index',
            value: '18,69 BMI',
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Sharing',
          ),
        ],
      ),
    );
  }
}
