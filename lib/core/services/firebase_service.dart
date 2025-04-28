import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discounttour/features/home/models/tour_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TourModel>> getTours() async {
    QuerySnapshot snapshot = await _firestore.collection('tours').get();
    return snapshot.docs.map((doc) => TourModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> bookTour({
    required String userId,
    required TourModel tour,
    required DateTime date,
    required int guests,
  }) async {
    await _firestore.collection('bookings').add({
      'userId': userId,
      'tourId': tour.id,
      'tourTitle': tour.title,
      'date': date,
      'guests': guests,
      'totalPrice': _calculateTotal(tour.price, guests),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  double _calculateTotal(String price, int guests) {
    final numericPrice = double.parse(price.replaceAll('\$', ''));
    return numericPrice * guests;
  }
}