import 'dart:convert';
import 'dart:io';
import 'package:bangladesh_finance_ekyc/shared/state/signup_state.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class NomineeService {
  static const String baseUrl = 'http://192.168.0.53:8070';
  // static const String baseUrl = 'http://172.50.10.121:8070';
  static Future<int?> submitNomineeDetails({
    required int ref_id,
    required String name,
    required String fatherName,
    required String motherName,
    required String relationship,
    required String address,
    required String dateOfBirth,
    required String nidNo,
  }) async {
    final nidId = SignupState().nidId;
    if (nidId == null) throw Exception("❌ Missing NID ID in SignupState");

    final payload = {
      "ref_id": nidId,
      "name": name,
      "father_name": fatherName,
      "mother_name": motherName,
      "relationship": relationship,
      "address": address,
      "date_of_birth": dateOfBirth,
      "nid_no": nidNo,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/nominee/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["nominee_id"] as int; // Cast the dynamic value to int
    } else {
      throw Exception("❌ Failed to submit nominee info: ${response.body}");
    }
  }

  static Future<void> uploadNomineeFiles({
    required int nomineeId,
    required File nomineeImage,
    required File nomineeSignature,
  }) async {
    final uri = Uri.parse('$baseUrl/nominee/upload-files/$nomineeId');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        await http.MultipartFile.fromPath(
          'nominee_picture',
          nomineeImage.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      )
      ..files.add(
        await http.MultipartFile.fromPath(
          'signature',
          nomineeSignature.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to upload nominee files');
    }
  }
}
