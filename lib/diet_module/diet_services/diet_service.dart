import 'dart:convert';
import 'package:http/http.dart' as http;
import '../diet_config/api_config.dart';
import '../diet_models/user_info.dart';
import '../diet_models/diet_plan_response.dart';

class DietService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  Future<DietPlanResponse> getDietRecommendations(UserInfo userInfo) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'api-key': ApiConfig.apiKey,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/get-recommendations'),
        headers: headers,
        body: jsonEncode(userInfo.toJson()),
      );

      if (response.statusCode == 200) {
        return DietPlanResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get diet recommendations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}