// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class Restaurant {
  final String id, name, description, pictureId, city;
  final num rating;
  final Map menus;
  final List categories, customerReviews;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.menus = const {},
    this.categories = const [],
    this.customerReviews = const [],
  });

  static List<Restaurant> getRestaurantsFromJson(String jsonData) {
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
      );
    }).toList();
  }

  static Future<dynamic> getRestaurantsFromAPI() async {
    print('calling list api');
    final url = Uri.parse('https://restaurant-api.dicoding.dev/list');
    try {
      final http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['error'] != false) {
        return Future.error(data['error']);
      }

      return Future.value(getRestaurantsFromJson(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }

  static Restaurant getRestaurantDetailFromJson(String jsonData) {
    final data = jsonDecode(jsonData);
    final restaurantData = data["restaurant"];
    return Restaurant(
        id: restaurantData["id"],
        name: restaurantData["name"],
        description: restaurantData["description"],
        pictureId: restaurantData["pictureId"],
        city: restaurantData["city"],
        rating: restaurantData["rating"],
        categories: restaurantData["categories"],
        menus: restaurantData["menus"],
        customerReviews: restaurantData["customerReviews"]);
  }

  static Future<dynamic> getRestaurantDetailFromAPI(String restaurantId) async {
    print('calling detail api');
    final url =
        Uri.parse('https://restaurant-api.dicoding.dev/detail/$restaurantId');
    try {
      final http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['error'] != false) {
        return Future.error(data['message']);
      }

      return Future.value(getRestaurantDetailFromJson(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<dynamic> findRestaurantsFromAPI(
      {required String searchTerm}) async {
    print('calling search api');
    final url =
        Uri.parse('https://restaurant-api.dicoding.dev/search?q=$searchTerm');
    try {
      final http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['error'] != false) {
        return Future.error(data['error']);
      }

      return Future.value(getRestaurantsFromJson(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }
}
