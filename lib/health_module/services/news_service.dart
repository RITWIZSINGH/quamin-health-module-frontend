import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quamin_health_module/health_module/models/news_model.dart';

class NewsService {
  static const String apiKey = 'a216021b1e7e43f285d153b5a8bd9967';
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> getHealthNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&category=health&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List)
          .map((article) => NewsArticle.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}