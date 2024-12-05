import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'TUES 11 JUL',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=100&h=100',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildHealthScore(context),
          const SizedBox(height: 24),
          _buildHighlights(context),
          const SizedBox(height: 24),
          _buildWeeklyReport(context),
        ],
      ),
    );
  }

  Widget _buildHealthScore(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Health Score'),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '78',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Based on your overview health tracking, your score is 78 and considered good.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Highlights',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View more'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildHighlightCard(
              context,
              icon: Icons.directions_walk,
              title: 'Steps',
              value: '11,857',
              subtitle: 'updated 15 min ago',
              color: Colors.blue,
            ),
            _buildHighlightCard(
              context,
              icon: Icons.calendar_today,
              title: 'Cycle tracking',
              value: '12 days before period',
              subtitle: 'updated 30m ago',
              color: Colors.pink,
            ),
            _buildHighlightCard(
              context,
              icon: Icons.nightlight_round,
              title: 'Sleep',
              value: '7h 31min',
              subtitle: 'updated a day ago',
              color: Colors.indigo,
            ),
            _buildHighlightCard(
              context,
              icon: Icons.restaurant,
              title: 'Nutrition',
              value: '960 kcal',
              subtitle: 'updated 5 min ago',
              color: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlightCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyReport(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'This week report',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View more'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildReportItem(
          icon: Icons.directions_walk,
          title: 'Steps',
          value: '697,978',
        ),
        _buildReportItem(
          icon: Icons.fitness_center,
          title: 'Workout',
          value: '6h 45min',
        ),
        _buildReportItem(
          icon: Icons.water_drop,
          title: 'Water',
          value: '10,659 ml',
        ),
        _buildReportItem(
          icon: Icons.bedtime,
          title: 'Sleep',
          value: '29h 17min',
        ),
      ],
    );
  }

  Widget _buildReportItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(title),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}