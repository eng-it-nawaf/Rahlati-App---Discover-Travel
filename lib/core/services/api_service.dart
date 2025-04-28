import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:discounttour/features/home/models/tour_model.dart';
import 'package:discounttour/features/home/models/country_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<TourModel>> getTours() async {
    final response = await http.get(Uri.parse('$baseUrl/tours'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => TourModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tours');
    }
  }

  Future<List<CountryModel>> getCountries() async {
    final response = await http.get(Uri.parse('$baseUrl/countries'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CountryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}