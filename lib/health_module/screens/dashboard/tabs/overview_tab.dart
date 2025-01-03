// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:quamin_health_module/health_module/models/news_model.dart';
import 'package:quamin_health_module/health_module/routes/custom_page_route.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/all_health_data_screen.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/highlightscreens/steps_screen.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/tabs/explore_tab.dart';
import 'package:quamin_health_module/health_module/screens/dashboard/tabs/news_detail_screen.dart';
import 'package:quamin_health_module/health_module/services/news_service.dart';
import 'package:quamin_health_module/health_module/services/step_services/step_service.dart';
import 'package:quamin_health_module/health_module/widgets/common/news_card.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  final NewsService _newsService = NewsService();
  final ScrollController _scrollController = ScrollController();
  List<NewsArticle> _articles = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMoreArticles = true;
  final StepService _stepService = StepService();

  String? _errorMessage;

  @override
void initState() {
  super.initState();
  _loadNews();
  _scrollController.addListener(_onScroll);
  _initializeStepService();
}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeStepService() async {
  try {
    await _stepService.initialize();
  } catch (e) {
    print('Error initializing step service: $e');
  }
}

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingMore &&
        _hasMoreArticles) {
      _loadMoreNews();
    }
  }

  Future<void> _loadMoreNews() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newArticles = await _newsService.getHealthNews(
        page: _currentPage + 1,
        forceRefresh: true,
      );

      if (!mounted) return;

      if (newArticles.isEmpty) {
        setState(() {
          _hasMoreArticles = false;
          _isLoadingMore = false;
        });
      } else {
        setState(() {
          _articles.addAll(newArticles);
          _currentPage++;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      print('Error loading more news: $e');
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _loadNews() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final articles = await _newsService.getHealthNews(
        page: 1,
        forceRefresh: true,
      );

      if (!mounted) return;

      setState(() {
        _articles = articles;
        _isLoading = false;
        _currentPage = 1;
        _hasMoreArticles = articles.length >= NewsService.articlesPerPage;
      });

      if (articles.isEmpty) {
        setState(() {
          _errorMessage = 'No news articles available';
        });
      }
    } catch (e) {
      if (!mounted) return;

      print('Error loading news: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load news';
        _articles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _loadNews,
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
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, double sw, double sh) {
    // Get current date and time
    final now = DateTime.now();

    // Format the date to get day and date
    final formatter = DateFormat('E dd MMM');
    final formattedDate = formatter.format(now);

    // Determine if it's day or night (assuming day is between 6 AM and 6 PM)
    final hour = now.hour;
    final isDaytime = hour >= 6 && hour < 18;
    final timeSymbol = isDaytime ? '☀' : '☾';

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
                    IconButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            context.go('/signin'); // Using go_router for navigation
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to logout: $e')),
                            );
                          }
                        }
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        size: sw / 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh / 100),
                Text(
                  '$timeSymbol ${formattedDate.toUpperCase()}',
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
    final cardHeight = sh / 2.8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Health News',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            ),
            // if (!_isLoading)
            //   IconButton(
            //     icon: Icon(Icons.refresh),
            //     onPressed: _loadNews,
            //   ),
          ],
        ),
        SizedBox(height: sh / 50),
        SizedBox(
          height: cardHeight,
          child: _isLoading && _articles.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _articles.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _errorMessage ?? 'No news available',
                            style: TextStyle(
                              color: _errorMessage != null
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                          if (_errorMessage != null) ...[
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _loadNews,
                              child: Text('Retry'),
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _articles.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _articles.length) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return NewsCard(
                          article: _articles[index],
                          width: sw / 1.4,
                          height: cardHeight,
                        );
                      },
                    ),
        ),
      ],
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
              onPressed: () {
                Navigator.push(context,
                    CustomPageRoute(child: const AllHealthDataScreen()));
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
  if (title == 'Steps') {
    return StreamBuilder<StepCount>(
      stream: _stepService.stepCountStream,
      builder: (context, snapshot) {
        return _buildStepCard(
          context,
          steps: snapshot.hasData ? snapshot.data!.steps.toString() : value,
          icon: icon,
          subtitle: subtitle,
          color: color,
          padding: padding,
        );
      },
    );
  }

  return _buildRegularCard(
    context,
    icon: icon,
    title: title,
    value: value,
    subtitle: subtitle,
    color: color,
    padding: padding,
  );
}

Widget _buildStepCard(
  BuildContext context, {
  required String steps,
  required IconData icon,
  required String subtitle,
  required Color color,
  required double padding,
}) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Current Steps'),
          content: Text('$steps steps'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
    onLongPress: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StepsScreen(),
        ),
      );
    },
    child: _buildCardContent(
      icon: icon,
      title: 'Steps',
      value: steps,
      subtitle: subtitle,
      color: color,
      padding: padding,
    ),
  );
}

Widget _buildRegularCard(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String value,
  required String subtitle,
  required Color color,
  required double padding,
}) {
  return _buildCardContent(
    icon: icon,
    title: title,
    value: value,
    subtitle: subtitle,
    color: color,
    padding: padding,
  );
}

Widget _buildCardContent({
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
      boxShadow: const [
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
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
          style: const TextStyle(
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

  Widget _buildCycleHighlightCard(
    BuildContext context, {
    required double padding,
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
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
        ],
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
