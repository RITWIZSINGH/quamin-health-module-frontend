import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:quamin_health_module/health_module/models/news_model.dart';

class NewsService {
  static const String apiKey = 'a216021b1e7e43f285d153b5a8bd9967';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> getHealthNews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/everything?q=health&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['status'] == 'ok' && data['articles'] != null) {
          final List<dynamic> articles = data['articles'];
          final List<NewsArticle> newsArticles = [];
          
          for (var article in articles) {
            try {
              NewsArticle newsArticle = NewsArticle.fromJson(article);
              // Fetch full content for each article
              if (newsArticle.url.isNotEmpty) {
                String? fullContent = await _fetchFullContent(newsArticle.url);
                if (fullContent != null && fullContent.isNotEmpty) {
                  newsArticle = newsArticle.copyWith(content: fullContent);
                }
              }
              newsArticles.add(newsArticle);
            } catch (e) {
              print('Error processing article: $e');
            }
          }
          return newsArticles;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getHealthNews: $e');
      rethrow;
    }
  }

  Future<String?> _fetchFullContent(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        },
      );

      if (response.statusCode == 200) {
        var document = parse(response.body);
        
        // Remove unwanted elements
        _removeUnwantedElements(document);
        
        // Try different potential content selectors
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

        // Fallback: Try to find the longest paragraph container
        var paragraphContainers = document.querySelectorAll('div').where((element) {
          var paragraphs = element.querySelectorAll('p');
          return paragraphs.length > 2; // Container must have at least 3 paragraphs
        }).toList();

        if (paragraphContainers.isNotEmpty) {
          // Sort by number of paragraphs
          paragraphContainers.sort((a, b) => 
            b.querySelectorAll('p').length.compareTo(a.querySelectorAll('p').length)
          );
          
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
      document.querySelectorAll(selector).forEach((element) => element.remove());
    }
  }

  String _cleanContent(Element element) {
    // Remove nested unwanted elements
    element.querySelectorAll('script, style, iframe, form').forEach((e) => e.remove());

    // Get all text nodes and paragraphs
    var content = element
        .querySelectorAll('p, h1, h2, h3, h4, h5, h6')
        .map((e) => e.text.trim())
        .where((text) => text.isNotEmpty)
        .join('\n\n');

    // Clean up the content
    content = content
        .replaceAll(RegExp(r'\s+'), ' ')  // Replace multiple spaces with single space
        .replaceAll(RegExp(r'\n\s*\n'), '\n\n')  // Replace multiple newlines with double newline
        .trim();

    return content;
  }
}