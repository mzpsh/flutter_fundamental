import 'dart:convert';

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
}
