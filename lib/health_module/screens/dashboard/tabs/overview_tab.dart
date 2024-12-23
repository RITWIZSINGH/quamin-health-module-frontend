// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/routes/custom_page_route.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/all_health_data_screen.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/tabs/explore_tab.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(sw / 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(context, sw, sh),
              SizedBox(height: sh / 30),
              _buildHealthScore(context),
              SizedBox(height: sh / 30),
              _buildHighlights(context),
              SizedBox(height: sh / 30),
              _buildWeeklyReport(context),
              SizedBox(height: sh / 30),
              _buildBlogsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, double sw, double sh) {
    return SizedBox(
      width: sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: sw / 20,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(sw / 50),
                        child: Image.asset(
                          "assets/logo/logo.png",
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: sw / 20,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=100&h=100',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh / 100),
                Text(
                  '☀ TUES 11 JUL',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Overview',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                child: const AllHealthDataScreen()));
                      },
                      child: Row(
                        children: [
                          const Text('All Data'),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: sw / 30,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogsSection(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Blogs',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
        ),
        SizedBox(height: sh / 50),
        SizedBox(
          height: sh / 3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Replace with actual number of blogs
            itemBuilder: (context, index) {
              return _buildBlogCard(context, sw, sh, index);
            },
          ),
        ),
      ],
    );
  }

  // Blog card widget
  Widget _buildBlogCard(BuildContext context, double sw, double sh, int index) {
    return Container(
      width: sw / 1.4,
      margin: EdgeInsets.only(right: sw / 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min, // Add this to minimize the column's height
        children: [
          Container(
            height: sh / 5.5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
              ],
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Text(
                'Blog Image ${index + 1}',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(sw / 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Add this to minimize the column's height
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blog Title ${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Read More >'),
                    ),
                  ],
                ),
                SizedBox(height: sh / 180),
                Text(
                  'Short description of the blog post goes here...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthScore(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Score',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
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
              color: Colors.black45,
              blurRadius: 8,
              blurStyle: BlurStyle.normal,
              offset: Offset(0, 4))
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
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ]),
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
