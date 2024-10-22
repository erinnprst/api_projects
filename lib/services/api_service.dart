import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artwork.dart';

class ApiService {
  final String baseUrl = 'https://api.artic.edu/api/v1/artworks';

  Future<List<Artwork>> fetchArtworks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Artwork.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load artworks');
    }
  }
}
