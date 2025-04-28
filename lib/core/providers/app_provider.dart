import 'package:discounttour/features/data/tour_data.dart';
import 'package:discounttour/features/home/models/country_model.dart';
import 'package:discounttour/features/home/models/tour_model.dart';
import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  List<TourModel> _tours = [];
  List<CountryModel> _countries = [];
  List<TourModel> _featuredTours = []; // أضف هذا السطر
  bool _isLoading = false;

  List<TourModel> get tours => _tours;
  List<CountryModel> get countries => _countries;
  List<TourModel> get featuredTours => _featuredTours; // أضف هذا السطر
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    try {
      _isLoading = true;
      notifyListeners();

      // استبدل هذا بطلب API فعلي إذا needed
      await Future.delayed(Duration(seconds: 1)); // محاكاة تحميل البيانات

      _tours = TourData.getTours();
      _countries = TourData.getCountries();
      _featuredTours = TourData.getFeaturedTours(); // أضف هذا السطر

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error loading data: $e');
    }
  }
}