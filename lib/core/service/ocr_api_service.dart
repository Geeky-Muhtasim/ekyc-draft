import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OcrApiService {
  static Future<Map<String, String>> extractNidData({
    required File frontImage,
    required File backImage,
  }) async {
    final uri = Uri.parse('http://192.168.0.53:8010/extract-nid');
    // final uri = Uri.parse('http://172.50.10.121/extract-nid');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'front',
        frontImage.path,
        contentType: MediaType.parse(_getMimeType(frontImage.path)),
      ))
      ..files.add(await http.MultipartFile.fromPath(
        'back',
        backImage.path,
        contentType: MediaType.parse(_getMimeType(backImage.path)),
      ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body) as Map<String, dynamic>;

      return {
        'nid': decoded['ID_No']?.toString() ?? '',
        'nameEn': decoded['NameEN']?.toString() ?? '',
        'nameBn': decoded['NameBN']?.toString() ?? '',
        'fatherBn': decoded['FatherBN']?.toString() ?? '',
        'motherBn': decoded['MotherBN']?.toString() ?? '',
        'dob': decoded['DateOfBirth']?.toString() ?? '',
        'presentAddress': decoded['AddressBN']?.toString() ?? '',
        'permanentAddress': '', // Optional, will be set by user later
      };
    } else {
      throw Exception('Failed to extract NID data: ${response.body}');
    }
  }

  static String _getMimeType(String path) {
    if (path.endsWith('.png')) return 'image/png';
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return 'image/jpeg';
    if (path.endsWith('.webp')) return 'image/webp';
    return 'application/octet-stream'; // fallback
  }
}
