import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Restaurant {
  final String id, name, description, pictureId, city;
  final num rating;
  final Map menus;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  static List<Restaurant> restaurantsFromJson(String jsonData) {
    final data = jsonDecode(jsonData);
    final List restaurantsData = data["restaurants"];
    return restaurantsData.map((restaurant) {
      return Restaurant(
          id: restaurant["id"],
          name: restaurant["name"],
          description: restaurant["description"],
          pictureId: restaurant["pictureId"],
          city: restaurant["city"],
          rating: restaurant["rating"],
          menus: restaurant["menus"]);
    }).toList();
  }

  static Future<List<Restaurant>> getLocalRestaurants(
      String jsonAssetPath) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      final jsonData = await rootBundle.loadString(jsonAssetPath);
      return restaurantsFromJson(jsonData);
    });
  }
}
