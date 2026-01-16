import '../core/constants/api_constants.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final double rating;
  final bool isTrending;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.rating = 0.0,
    this.isTrending = false,
  });



  factory Product.fromMap(Map<String, dynamic> map, String id) {
    String imageUrl = map['imageUrl'] ?? '';
    if (imageUrl.startsWith('/')) {
       // ApiConstants.baseUrl likely ends with /api, we need root. 
       // If ApiConstants.baseUrl is http://host:port/api, we want http://host:port/images/...
       // So we should strip /api or just use the host. 
       // Simplest approach: expect ApiConstants to provide a separate `assetBaseUrl` or derive it.
       // Let's assume we replace /api with empty or just string matching.
       // Actually ApiConstants.baseUrl getter logic:
       // http://localhost:3000/api
       // We want http://localhost:3000
       final baseUrl = ApiConstants.baseUrl.replaceAll('/api', '');
       imageUrl = '$baseUrl$imageUrl';
    }

    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: imageUrl,
      categoryId: map['categoryId'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      isTrending: map['isTrending'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'rating': rating,
      'isTrending': isTrending,
    };
  }
}
