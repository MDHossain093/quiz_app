import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/categories"),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json["success"] == true) {
        return (json["data"] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    }

    throw Exception("Failed to load categories");
  }
}