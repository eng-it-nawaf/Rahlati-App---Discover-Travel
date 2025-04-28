import 'package:discounttour/features/home/models/country_model.dart' show CountryModel;
import 'package:discounttour/features/home/models/tour_model.dart' show TourModel;
import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../../core/services/api_service.dart';

class HomeViewModel with ChangeNotifier {
  final ApiService _apiService;

  List<CountryModel> _countries = [];
  List<TourModel> _tours = [];
  bool _isLoading = true;

  HomeViewModel({required ApiService apiService}) : _apiService = apiService;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _countries = await _apiService.getCountries();
      _tours = await _apiService.getTours();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}