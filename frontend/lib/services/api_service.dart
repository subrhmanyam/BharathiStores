import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../models/home_data_model.dart';
import '../models/product_model.dart';

class ApiService {
  Future<HomeData> fetchHomeData() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.home));
      
      if (response.statusCode == 200) {
        return HomeData.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load home data');
      }
    } catch (e) {
      throw Exception('Error fetching home data: $e');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.productsByCategory(categoryId)));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromMap(json, json['id'])).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
