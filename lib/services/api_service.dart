import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:findoc_assignment/models/image_item.dart';

class ApiService {
  static const String baseUrl = 'https://picsum.photos';

  Future<List<ImageItem>> getImages({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v2/list?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ImageItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load images: $e');
    }
  }

  String getImageUrl(String id, int width, int height) {
    return '$baseUrl/id/$id/$width/$height';
  }
} 