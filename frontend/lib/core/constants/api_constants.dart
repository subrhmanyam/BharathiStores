import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConstants {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS Simulator/Web
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:3000/api';
    if (Platform.isAndroid) return 'http://10.0.2.2:3000/api';
    return 'http://localhost:3000/api';
  }

  static String get home => '$baseUrl/home';
  static String productsByCategory(String categoryId) => '$baseUrl/products/$categoryId';
}
