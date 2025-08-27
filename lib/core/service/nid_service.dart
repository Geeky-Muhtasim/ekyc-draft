import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:bangladesh_finance_ekyc/core/config.dart';

class NidService {
  static Future<int> submitNidData({
    required String nid,
    required String nameEn,
    required String nameBn,
    required String fatherNameBn,
    required String motherNameBn,
    required String dob, // formatted yyyy-MM-dd
    required String presentAddress,
    required String permanentAddress,
  }) async {
    final url = Uri.parse('http://192.168.0.53:8070/nid/');
    // final url = Uri.parse('http://172.50.10.121:8070/nid/');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nid": nid,
        "name_en": nameEn,
        "name_bn": nameBn,
        "father_name_bn": fatherNameBn,
        "mother_name_bn": motherNameBn,
        "date_of_birth": dob,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['id_no'] as int; // Cast the dynamic value to int
    } else {
      throw Exception("Failed to submit NID data: ${response.body}");
    }
  }
}
