import 'package:http/http.dart' as http;
import 'package:quamin_health_module/health_module/health_models/news_model.dart';
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:quamin_health_module/health_module/health_services/news_service.dart';

class MenstrualNewsService {
  static const String apiKey = 'a216021b1e7e43f285d153b5a8bd9967';
  static const String baseUrl = 'https://newsapi.org/v2';
  static const int articlesPerPage = 10;

  List<NewsArticle> _cachedArticles = [];

 
  Future<List<NewsArticle>> getMenstrualHealthNews({int page = 1, bool forceRefresh = false}) async {
    try {
      if (forceRefresh || _cachedArticles.isEmpty || page > 1) {
        final response = await http.get(
          Uri.parse(
            '$baseUrl/everything?q=menstrual+health+period&pageSize=${articlesPerPage * 2}&page=$page&sortBy=publishedAt&apiKey=$apiKey'
          ),
          // Fetch more articles than needed to account for filtered ones
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          
          if (data['status'] == 'ok' && data['articles'] != null) {
            final List<dynamic> articles = data['articles'];
            final List<NewsArticle> newsArticles = [];
            
            for (var article in articles) {
              if (article is Map<String, dynamic> && article.isValidArticle()) {
                try {
                  NewsArticle newsArticle = NewsArticle.fromJson(article);
                  if (newsArticle.url.isNotEmpty) {
                    String? fullContent = await _fetchFullContent(newsArticle.url);
                    if (fullContent != null && fullContent.isNotEmpty) {
                      newsArticle = newsArticle.copyWith(content: fullContent);
                    }
                  }
                  newsArticles.add(newsArticle);
                  
                  // Break if we have enough valid articles
                  if (newsArticles.length >= articlesPerPage) {
                    break;
                  }
                } catch (e) {
                  print('Error processing article: $e');
                }
              }
            }

            if (page == 1) {
              _cachedArticles = newsArticles;
            }

            return newsArticles;
          }
        }
        throw Exception('Failed to load news: ${response.statusCode}');
      } else {
        return _cachedArticles;
      }
    } catch (e) {
      print('Error fetching menstrual health news: $e');
      rethrow;
    }
  }
  Future<String?> _fetchFullContent(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        },
      );

      if (response.statusCode == 200) {
        var document = parse(response.body);

        _removeUnwantedElements(document);

        final List<String> contentSelectors = [
          'article',
          '.article-content',
          '.post-content',
          '.entry-content',
          '.content',
          'main',
          '[itemprop="articleBody"]',
          '.story-body',
          '.article-body',
          '#article-body',
          '.post-body',
        ];

        for (var selector in contentSelectors) {
          var contentElement = document.querySelector(selector);
          if (contentElement != null) {
            String content = _cleanContent(contentElement);
            if (content.isNotEmpty) {
              return content;
            }
          }
        }

        var paragraphContainers =
            document.querySelectorAll('div').where((element) {
          var paragraphs = element.querySelectorAll('p');
          return paragraphs.length > 2;
        }).toList();

        if (paragraphContainers.isNotEmpty) {
          paragraphContainers.sort((a, b) => b
              .querySelectorAll('p')
              .length
              .compareTo(a.querySelectorAll('p').length));

          return _cleanContent(paragraphContainers.first);
        }
      }
    } catch (e) {
      print('Error fetching full content: $e');
    }
    return null;
  }

  void _removeUnwantedElements(Document document) {
    final unwantedSelectors = [
      'header',
      'footer',
      'nav',
      '.advertisement',
      '.social-share',
      '.comments',
      'script',
      'style',
      '.sidebar',
      '.related-articles',
      '.newsletter-signup',
      '.popup',
      '.modal',
    ];

    for (var selector in unwantedSelectors) {
      document
          .querySelectorAll(selector)
          .forEach((element) => element.remove());
    }
  }

  String _cleanContent(Element element) {
    element
        .querySelectorAll('script, style, iframe, form')
        .forEach((e) => e.remove());

    var content = element
        .querySelectorAll('p, h1, h2, h3, h4, h5, h6')
        .map((e) => e.text.trim())
        .where((text) => text.isNotEmpty)
        .join('\n\n');

    content = content
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\n\s*\n'), '\n\n')
        .trim();

    return content;
  }
}
