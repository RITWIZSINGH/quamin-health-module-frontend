// ignore_for_file: unused_local_variable

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
                    '☀ TUES 11 JUL',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.2),
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
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Highlights',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Text('View more'),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  )
                ],
              ),
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
          childAspectRatio: 1,
          children: [
            _buildHighlightCard(
              context,
              padding: sw / 30,
              icon: Icons.directions_walk,
              title: 'Steps',
              value: '11,857',
              subtitle: 'updated 15 min ago',
              color: Color(0xFF878CED),
            ),
            _buildCycleHighlightCard(
              context,
              padding: sw / 30,
              icon: Icons.calendar_today,
              title: 'Cycle tracking',
              value: '12 days before period',
              subtitle: 'updated 30m ago',
              color: Color(0xFFEFA98D),
            ),
            _buildHighlightCard(
              context,
              padding: sw / 30,
              icon: Icons.nightlight_round_outlined,
              title: 'Sleep',
              value: '7h 31min',
              subtitle: 'updated a day ago',
              color: Color(0xFF125D95),
            ),
            _buildHighlightCard(
              context,
              padding: sw / 30,
              icon: Icons.restaurant,
              title: 'Nutrition',
              value: '960 kcal',
              subtitle: 'updated 5 min ago',
              color: Color(0xFF5B27D5),
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
    required double padding,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyReport(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'This week report',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Text('View more'),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        //Weekly report grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildReportItem(
              iconColor: Colors.yellowAccent.shade700,
              valueInputSize: sh / 34,
              icon: Icons.directions_walk,
              title: 'Steps',
              value: '697,978',
              padding: sw / 20,
            ),
            _buildReportItem(
              iconColor: Colors.blueGrey.shade800,
              valueInputSize: sh / 34,
              icon: Icons.fitness_center,
              title: 'Workout',
              padding: sw / 30,
              value: '6h 45min',
            ),
            _buildReportItem(
              iconColor: Colors.blue,
              valueInputSize: sh / 34,
              icon: Icons.water_drop,
              title: 'Water',
              value: '10,659 ml',
              padding: sw / 30,
            ),
            _buildReportItem(
              valueInputSize: sh / 34,
              padding: sw / 30,
              icon: Icons.bedtime,
              iconColor: Colors.black,
              title: 'Sleep',
              value: '29h 17min',
            ),
          ],
        )
      ],
    );
  }

  Widget _buildReportItem({
    required IconData icon,
    required String title,
    required String value,
    required double padding,
    required double valueInputSize,
    required Color? iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black, blurRadius: 1, blurStyle: BlurStyle.normal)
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: valueInputSize),
          ),
        ],
      ),
    );
  }

  //As cycle highligh card has more text , its card is made seperate
  _buildCycleHighlightCard(BuildContext context,
      {required double padding,
      required IconData icon,
      required String title,
      required String value,
      required String subtitle,
      required Color color}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
