import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpService {
  final String baseUrl = 'https://192.168.0.53:8070'; // replace with real backend URL

  Future<Map<String, dynamic>> sendOtp(String mobileNo) async {
    final url = Uri.parse('$baseUrl/otp/send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"mobileno": mobileNo}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required int otpId,
    required String otpCodeSms,
  }) async {
    final url = Uri.parse('$baseUrl/otp/verify');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "otp_id": otpId,
        "otp_code_sms": otpCodeSms,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to verify OTP');
    }
  }
}
