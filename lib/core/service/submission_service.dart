// lib/core/service/submission_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubmissionService {
  // TODO: replace with your real endpoint
  static const String _submitUrl = 'https://example.com/api/submit-application';

  static Future<void> submitFinalApplication(Map<String, dynamic> payload) async {
    final resp = await http.post(
      Uri.parse(_submitUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Submit failed (HTTP ${resp.statusCode}): ${resp.body}');
    }
  }
}
