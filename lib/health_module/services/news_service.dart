import 'dart:convert';
import 'package:http/http.dart' as http;
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
          return articles.map((article) {
            try {
              return NewsArticle.fromJson(article);
            } catch (e) {
              print('Error parsing article: $e');
              return null;
            }
          }).whereType<NewsArticle>().toList();
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
}