import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_fundamental/models/restaurant.dart';

class RestaurantGetter {
  static Future<dynamic> getRestaurantsFromAPI() async {
    final url = Uri.parse('https://restaurant-api.dicoding.dev/list');
    try {
      final http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['error'] != false) {
        return Future.error(data['error']);
      }

      return Future.value(Restaurant.getRestaurantsFromJson(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<dynamic> getRestaurantDetailFromAPI(String restaurantId) async {
    final url =
        Uri.parse('https://restaurant-api.dicoding.dev/detail/$restaurantId');
    try {
      final http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['error'] != false) {
        return Future.error(data['message']);
      }

      return Future.value(
          Restaurant.getRestaurantDetailFromJson(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<dynamic> findRestaurantsFromAPI(
      {required String searchTerm}) async {
    final url =
        Uri.parse('https://restaurant-api.dicoding.dev/search?q=$searchTerm');
    try {
      final http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['error'] != false) {
        return Future.error(data['error']);
      }

      return Future.value(Restaurant.getRestaurantsFromJson(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }
}
