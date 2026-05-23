import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> analyzeText(String text) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/analyze"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "description": text,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}