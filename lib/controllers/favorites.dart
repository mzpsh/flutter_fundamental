import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:get/get.dart';

class FavoriteRestaurants extends GetxController {
  var favoriteRestaurants = <Restaurant>[].obs;

  bool checkIfRestaurantHasBeenFavorited(Restaurant restaurant) {
    for (var item in favoriteRestaurants) {
      if (item.id == restaurant.id) {
        return true;
      }
    }
    return false;
  }

  String toggleRestaurantToFavorite(Restaurant restaurant) {
    if (!checkIfRestaurantHasBeenFavorited(restaurant)) {
      favoriteRestaurants.add(restaurant);
      return 'Added to favorites.';
    } else {
      favoriteRestaurants
          .removeWhere((Restaurant element) => element.id == restaurant.id);
      return 'Removed from favorites.';
    }
  }
}
