import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:findoc_assignment/models/image_item.dart';

class ApiService {
  static const String baseUrl = 'https://picsum.photos';
  
 
  static const List<int> imageIds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  Future<List<ImageItem>> getImages({int limit = 10}) async {
    try {

      List<ImageItem> images = [];
      
      for (int i = 0; i < limit && i < imageIds.length; i++) {
        final id = imageIds[i];
       
        images.add(ImageItem(
          id: id.toString(),
          author: 'Coder',
          width: 800,
          height: 600,
          url: '$baseUrl/id/$id/800/600',
          downloadUrl: '$baseUrl/id/$id/800/600',
        ));
      }
      
      return images;
    } catch (e) {
      throw Exception('Failed to load images: $e');
    }
  }

  String getImageUrl(String id, int width, int height) {
    return '$baseUrl/id/$id/$width/$height';
  }

  String getRandomImageUrl(int width, int height, String seed) {
    return '$baseUrl/id/$seed/$width/$height';
  }
} 