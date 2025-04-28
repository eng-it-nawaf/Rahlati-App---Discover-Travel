class CountryModel {
  final String id;
  final String name;
  final String label;
  final String imageUrl;
  final double rating;
  final int tourCount;

  CountryModel({
    required this.id,
    required this.name,
    required this.label,
    required this.imageUrl,
    required this.rating,
    required this.tourCount,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      label: json['label'] ?? 'New',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      tourCount: json['tourCount'] ?? 0,
    );
  }
}

// class CountryModel {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final int tourCount;
//
//   CountryModel({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.tourCount,
//   });
//
//   factory CountryModel.fromJson(Map<String, dynamic> json) {
//     return CountryModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       imageUrl: json['imageUrl'] ?? '',
//       tourCount: json['tourCount'] ?? 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'imageUrl': imageUrl,
//       'tourCount': tourCount,
//     };
//   }
// }