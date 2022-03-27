import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_fundamental/models/restaurant.dart';

class DatabaseHelper {
  static Database? database;

  static getDatabase() async {
    if (database == null) {
      DatabaseFactory dbFactory = databaseFactoryIo;
      var appDocumentDirectory = await getApplicationDocumentsDirectory();
      var path = join(appDocumentDirectory.path, 'flutter_fundamental.db');
      database = await dbFactory.openDatabase(path);
    }
    return database;
  }
}

class FavoritesController extends GetxController {
  var favoriteRestaurants = <Restaurant>[].obs;

  @override
  void onInit() async {
    super.onInit();
    var db = await DatabaseHelper.getDatabase();
    var favoriteRecord = StoreRef.main().record('favorites');
    var currentFavorites = await favoriteRecord.get(db);

    /// This is for rejected submission 1076113.
    /// Current database null checking.
    /// Don't retrieve and refresh the state
    /// if the database it empty.
    if (currentFavorites != null) {
      favoriteRestaurants.addAll(
        Restaurant.getRestaurantsFromJson(currentFavorites),
      );
    }

    ever(favoriteRestaurants, (List<Restaurant> restaurants) async {
      final jsonData = Restaurant.getJsonFromRestaurants(restaurants);
      await favoriteRecord.put(db, jsonData, merge: false);
    });
  }

  bool checkIfRestaurantHasBeenFavorited(Restaurant restaurant) {
    for (var item in favoriteRestaurants) {
      if (item.id == restaurant.id) {
        return true;
      }
    }
    return false;
  }

  Future<String> toggleRestaurantToFavorite(Restaurant restaurant) {
    if (!checkIfRestaurantHasBeenFavorited(restaurant)) {
      favoriteRestaurants.add(restaurant);
      return Future.value('Added to favorites.');
    } else {
      favoriteRestaurants
          .removeWhere((Restaurant element) => element.id == restaurant.id);
      return Future.value('Removed from favorites.');
    }
  }
}
