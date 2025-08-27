import 'dart:convert';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:http/http.dart' as http;

class AdditionalInfoService {
  static const String baseUrl = 'http://192.168.0.53:8070';
  // static const String baseUrl = 'http://172.50.10.121:8070';

  static Future<int?> postAdditionalInfoData({
    required String etinNo,
    required String religion,
    required String country,
    required int divisionId,
    required int districtId,
    required int thanaId,
    required String netWorthId,
    required String gender,
    required String occupation,
  }) async {
    final nidId = SignupState().nidId;

    if (nidId == null) throw Exception("nidId is null in SignupState");

    final body = {
      "etin_no": etinNo,
      "religion": religion,
      "country": country,
      "division_id": divisionId,
      "district_id": districtId,
      "thana_id": thanaId,
      "net_worth_id": netWorthId,
      "gender": gender,
      "occupation": occupation,
      "id_no": nidId,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/additional-info-data/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final additionalInfoId = data['id_no'];
      SignupState().additionalInfoId = additionalInfoId as int?;
      return additionalInfoId;
    } else {
      throw Exception('Failed to submit additional info');
    }
  }
}
