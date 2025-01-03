import 'package:http/http.dart' as http;
import 'package:quamin_health_module/health_module/health_models/news_model.dart';
import 'dart:convert';

class MenstrualNewsService {
  static const String apiKey = 'a216021b1e7e43f285d153b5a8bd9967';
  static const String baseUrl = 'https://newsapi.org/v2';
  
  Future<List<NewsArticle>> getMenstrualHealthNews() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/everything?q=menstrual+health+period&pageSize=10&sortBy=publishedAt&apiKey=$apiKey'
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        if (data['status'] == 'ok' && data['articles'] != null) {
          return (data['articles'] as List)
              .map((article) => NewsArticle.fromJson(article))
              .toList();
        }
      }
      throw Exception('Failed to load menstrual health news');
    } catch (e) {
      print('Error fetching menstrual health news: $e');
      return [];
    }
  }
}