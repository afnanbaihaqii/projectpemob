import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/adoption_request.dart';

Future<void> sendAdoptionRequest(AdoptionRequest request) async {
  final url = 'https://your-api-url.com/adoption-requests'; // Backend endpoint
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to send adoption request');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
