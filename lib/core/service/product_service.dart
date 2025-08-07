import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'http://192.168.0.53:8070'; // Replace with actual

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/product/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List<dynamic>;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
