import 'product_model.dart';
import 'category_model.dart';

class HomeData {
  final List<String> banners;
  final List<Category> categories;
  final List<Product> trending;

  HomeData({
    required this.banners,
    required this.categories,
    required this.trending,
  });

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      banners: List<String>.from(map['banners'] ?? []),
      categories: (map['categories'] as List<dynamic>?)
          ?.map((x) => Category.fromMap(x))
          .toList() ?? [],
      trending: (map['trending'] as List<dynamic>?)
          ?.map((x) => Product.fromMap(x, x['id'] ?? ''))
          .toList() ?? [],
    );
  }
}
