import 'package:discounttour/features/home/models/country_model.dart';
import 'package:discounttour/features/home/models/tour_model.dart';

/// Class that contains all the mock data for the application
/// يمكن استبدال هذه البيانات بطلب API حقيقي في المستقبل
class TourData {
  // قائمة الدول السياحية
  static List<CountryModel> getCountries() {
    return [
      CountryModel(
        id: '1',
        name: 'Thailand',
        label: 'New',
        imageUrl: 'https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg',
        rating: 4.5,
        tourCount: 18,
      ),
      CountryModel(
        id: '2',
        name: 'Malaysia',
        label: 'Sale',
        imageUrl: 'https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg',
        rating: 4.3,
        tourCount: 12,
      ),
      CountryModel(
        id: '3',
        name: 'Indonesia',
        label: 'Popular',
        imageUrl: 'https://images.pexels.com/photos/3568489/pexels-photo-3568489.jpeg',
        rating: 4.7,
        tourCount: 15,
      ),
      CountryModel(
        id: '4',
        name: 'Vietnam',
        label: 'New',
        imageUrl: 'https://images.pexels.com/photos/2901215/pexels-photo-2901215.jpeg',
        rating: 4.2,
        tourCount: 10,
      ),
      CountryModel(
        id: '5',
        name: 'Philippines',
        label: 'Hot',
        imageUrl: 'https://images.pexels.com/photos/2901215/pexels-photo-2901215.jpeg',
        rating: 4.6,
        tourCount: 14,
      ),
    ];
  }

  // قائمة الجولات السياحية الشعبية
  static List<TourModel> getTours() {
    return [
      TourModel(
        id: '1',
        title: 'Thailand Adventure',
        description: '10 nights for two/all inclusive',
        price: '\$245.50',
        rating: 4.0,
        imageUrl: 'https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg',
        location: 'Bangkok, Thailand',
      ),
      TourModel(
        id: '2',
        title: 'Cuba Beach Resort',
        description: '7 nights luxury experience',
        price: '\$499.99',
        rating: 4.5,
        imageUrl: 'https://images.pexels.com/photos/1658967/pexels-photo-1658967.jpeg',
        location: 'Havana, Cuba',
      ),
      TourModel(
        id: '3',
        title: 'Dominican Paradise',
        description: '5 nights all inclusive deal',
        price: '\$320.00',
        rating: 4.2,
        imageUrl: 'https://images.pexels.com/photos/1477430/pexels-photo-1477430.jpeg',
        location: 'Punta Cana, Dominican Republic',
      ),
      TourModel(
        id: '4',
        title: 'Bali Cultural Tour',
        description: '8 nights with guided tours',
        price: '\$380.75',
        rating: 4.8,
        imageUrl: 'https://images.pexels.com/photos/1743165/pexels-photo-1743165.jpeg',
        location: 'Bali, Indonesia',
      ),
      TourModel(
        id: '5',
        title: 'Maldives Getaway',
        description: '6 nights in overwater bungalow',
        price: '\$750.00',
        rating: 4.9,
        imageUrl: 'https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg',
        location: 'Malé, Maldives',
      ),
      TourModel(
        id: '6',
        title: 'Greek Islands Cruise',
        description: '9 nights island hopping',
        price: '\$620.50',
        rating: 4.7,
        imageUrl: 'https://images.pexels.com/photos/1020016/pexels-photo-1020016.jpeg',
        location: 'Athens, Greece',
      ),
    ];
  }

  // الحصول على جولة بواسطة ID
  static TourModel? getTourById(String id) {
    try {
      return getTours().firstWhere((tour) => tour.id == id);
    } catch (e) {
      return null;
    }
  }

  // الحصول على دولة بواسطة ID
  static CountryModel? getCountryById(String id) {
    try {
      return getCountries().firstWhere((country) => country.id == id);
    } catch (e) {
      return null;
    }
  }

  // الحصول على جولات لدولة معينة
  static List<TourModel> getToursByCountry(String countryName) {
    return getTours()
        .where((tour) => tour.title.toLowerCase().contains(countryName.toLowerCase()))
        .toList();
  }

  // الحصول على جولات مميزة (تقييم عالي)
  static List<TourModel> getFeaturedTours({double minRating = 4.5}) {
    return getTours().where((tour) => tour.rating >= minRating).toList();
  }
}