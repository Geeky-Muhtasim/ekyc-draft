import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bangladesh_finance_ekyc/model/branch_model.dart';

class BranchService {
  // TODO: replace with your real endpoint
  static const String _apiUrl = 'http://192.168.0.53:8070/bank_details/branches';

  /// Fetch all branches from API.
  static Future<List<Branch>> fetchBranches() async {
    final resp = await http.get(Uri.parse(_apiUrl), headers: {
      'Accept': 'application/json',
    });

    if (resp.statusCode != 200) {
      throw Exception('Failed to fetch branches: HTTP ${resp.statusCode}');
    }

    final body = jsonDecode(resp.body);
    if (body is! List) {
      throw Exception('Unexpected branches response shape');
    }

    return body.map<Branch>((e) => Branch.fromJson(e as Map<String, dynamic>)).toList();
  }
}
