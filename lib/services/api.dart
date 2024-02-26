import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Map<String, dynamic>>> fetchCharacters() async {
    try {
      final response = await _dio.get('$baseUrl/character');

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return List<Map<String, dynamic>>.from(results);
      } else {
        throw Exception('failed to load characters');
      }
    } catch (error) {
      throw Exception('Error fetching characters: $error');
    }
  }

  Future<List<Map<String, dynamic>>> fetchLocations() async {
    try {
      final response = await _dio.get('$baseUrl/location');

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return List<Map<String, dynamic>>.from(results);
      } else {
        throw Exception('failed to load locations');
      }
    } catch (error) {
      throw Exception('Error fetching locations: $error');
    }
  }
}
