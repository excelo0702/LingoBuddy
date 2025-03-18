import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/word.dart';

class ApiService {
  final String baseUrl = 'http://localhost:1337/api';

  Future<List<Word>> fetchWords() async {
    final response = await http.get(Uri.parse('$baseUrl/words?populate=image'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => Word.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words');
    }
  }

  Future<List<Word>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/words?populate=image'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => Word.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words');
    }
  }

  Future<List<Word>> fetchChapters() async {
    final response = await http.get(Uri.parse('$baseUrl/words?populate=image'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => Word.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load words');
    }
  }

}
