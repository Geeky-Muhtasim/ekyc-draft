// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class PhotoReportService {
//   static const String baseUrl = "http://192.168.0.53:8070"; // adjust if needed

//   static Future<void> updateUserPhoto({
//     required int trackingNo,
//     File? userPhoto,
//     File? userSign,
//   }) async {
//     final uri = Uri.parse("$baseUrl/photo-report/update-photo")
//         .replace(queryParameters: {
//       "tracking_no": trackingNo.toString(),
//     });

//     final request = http.MultipartRequest("PUT", uri);

//     if (userPhoto != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath("user_photo", userPhoto.path),
//       );
//     }

//     if (userSign != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath("user_sign", userSign.path),
//       );
//     }

//     final response = await http.Response.fromStream(await request.send());

//     if (response.statusCode != 200) {
//       throw Exception(
//         "Failed to update user photo: ${response.body}",
//       );
//     }
//   }
// }

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class PhotoReportService {
  static const String baseUrl = "http://192.168.0.53:8070"; // Adjust if needed
  // static const String baseUrl = "http://172.50.10.121:8070"; // Adjust if needed

  static Future<void> updateUserPhoto({
    required int trackingNo,
    File? userPhoto,
    File? userSign,
  }) async {
    final uri = Uri.parse("$baseUrl/photo-report/update-photo")
        .replace(queryParameters: {
      "tracking_no": trackingNo.toString(),
    });

    final request = http.MultipartRequest("PUT", uri);

    if (userPhoto != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "user_photo",
          userPhoto.path,
          contentType: MediaType.parse(
              lookupMimeType(userPhoto.path) ?? 'image/jpeg'),
        ),
      );
    }

    if (userSign != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "user_sign",
          userSign.path,
          contentType: MediaType.parse(
              lookupMimeType(userSign.path) ?? 'image/png'),
        ),
      );
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode != 200) {
      throw Exception("Failed to update photo/signature: ${response.body}");
    }
  }
}
