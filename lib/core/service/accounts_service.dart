import 'dart:convert';

import 'package:bangladesh_finance_ekyc/core/config.dart';
import 'package:http/http.dart' as http;

class AccountsService {
  static Future<int> createSchemeAccount({
    required int schemeId,
    required int productCode,
    required int productType,
    required int tenureMonths,
    required String branchId,
    double? amount,
    double? monthlyDeposit,
  }) async {
    final uri = Uri.parse('$baseApiUrl/accounts/scheme');
    final body = <String, dynamic>{
      'scheme_id': schemeId,
      'product_code': productCode,
      'product_type': productType,
      'tenure': tenureMonths,
      'branch_id': branchId,
    };

    // API expects these keys present; send monthly_deposit and set others nullable
    body['monthly_deposit'] = monthlyDeposit;
    body['amount'] = amount; // can be null
    body['maturity_date'] = null; // nullable per backend
    body['maturity_amount'] = null; // nullable per backend

    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Failed to create scheme account: HTTP ${resp.statusCode} ${resp.body}');
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final id = data['id'];
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? (throw Exception('Invalid id in response'));
    throw Exception('Missing id in createSchemeAccount response');
  }

  static Future<int> createTimeAccount({
    required int productCode,
    required int productType,
    required int tenureMonths,
    required double amount,
    required String branchId,
    String? accountCreatedAtIso, // optional, e.g., yyyy-MM-dd
  }) async {
    final uri = Uri.parse('$baseApiUrl/accounts/time');
    final body = <String, dynamic>{
      'product_code': productCode,
      'product_type': productType,
      'tenure': tenureMonths,
      'amount': amount,
      'branch_id': branchId,
    };

    // Backend expects the key present; allow null
    body['account_created_at'] = accountCreatedAtIso;

    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Failed to create time account: HTTP ${resp.statusCode} ${resp.body}');
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final id = data['id'];
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? (throw Exception('Invalid id in response'));
    throw Exception('Missing id in createTimeAccount response');
  }
}


