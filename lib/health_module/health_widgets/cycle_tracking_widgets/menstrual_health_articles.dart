import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/health_models/news_model.dart';
import 'package:quamin_health_module/health_module/health_services/cycle_tracking_services/menstrual_news_service.dart';
import 'package:quamin_health_module/health_module/health_widgets/common/news_card.dart';

class HealthArticles extends StatefulWidget {
  const HealthArticles({super.key});

  @override
  State<HealthArticles> createState() => _HealthArticlesState();
}

class _HealthArticlesState extends State<HealthArticles> {
  final ScrollController _scrollController = ScrollController();
  final MenstrualNewsService _newsService = MenstrualNewsService();
  List<NewsArticle> _articles = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  bool _hasMoreArticles = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoadingMore &&
        _hasMoreArticles) {
      _loadMoreArticles();
    }
  }

  Future<void> _loadMoreArticles() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newArticles = await _newsService.getMenstrualHealthNews(
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
      print('Error loading more articles: $e');
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _loadArticles() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final articles = await _newsService.getMenstrualHealthNews(
        page: 1,
        forceRefresh: true,
      );

      if (!mounted) return;

      setState(() {
        _articles = articles;
        _isLoading = false;
        _currentPage = 1;
        _hasMoreArticles = articles.length >= 10; // Assuming 10 articles per page
      });

      if (articles.isEmpty) {
        setState(() {
          _errorMessage = 'No articles available';
        });
      }
    } catch (e) {
      if (!mounted) return;

      print('Error loading articles: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load articles';
        _articles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    final cardHeight = sh / 2.8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Menstrual Health',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!_isLoading)
              TextButton(
                onPressed: _loadArticles,
                child: const Text('Refresh'),
              ),
          ],
        ),
        const SizedBox(height: 16),
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
                            _errorMessage ?? 'No articles available',
                            style: TextStyle(
                              color: _errorMessage != null
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                          if (_errorMessage != null) ...[
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _loadArticles,
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
}