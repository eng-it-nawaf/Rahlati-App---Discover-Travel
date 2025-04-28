class TourModel {
  final String id;
  final String title;
  final String description;
  final String price;
  final double rating;
  final String imageUrl;
  final String location; // Add this line


  TourModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.location, // Add this line

  });

  // Convert JSON to TourModel
  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '\$0.00',
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? '',

    );
  }

  // Convert TourModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'location': location,
    };
  }
}