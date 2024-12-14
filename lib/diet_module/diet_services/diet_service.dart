import 'dart:convert';
import 'package:http/http.dart' as http;
import '../diet_config/api_config.dart';
import '../diet_models/user_info.dart';
import '../diet_models/diet_plan_response.dart';

class DietService {
  static const String baseUrl = 'http://localhost:8000'; // Replace with your actual IP

  Future<DietPlanResponse> getDietRecommendations(UserInfo userInfo) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/get-recommendations'),
        headers: headers,
        body: jsonEncode(userInfo.toJson()),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return DietPlanResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to get diet recommendations: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error making request: $e');
      throw Exception('Error making request: $e');
    }
  }
}