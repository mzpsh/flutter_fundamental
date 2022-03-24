import "package:flutter_fundamental/models/restaurant.dart";
import "package:test/test.dart";

void main() {
  test("getRestaurantDetailFromJson should return a complete Restaurant object",
      () {
    final restaurant = Restaurant.getRestaurantDetailFromJson("""
{
  "restaurant" : {
    "id": "testId",
    "name": "testName",
    "description": "testDescription",
    "pictureId": "testPictureId",
    "city": "testCity",
    "rating": 1,
    "categories": [],
    "customerReviews": [],
    "menus": {}
  }
}
""");

    expect(restaurant.id, "testId");
    expect(restaurant.name, "testName");
    expect(restaurant.description, "testDescription");
    expect(restaurant.pictureId, "testPictureId");
    expect(restaurant.city, "testCity");
    expect(restaurant.rating, 1);
    expect(restaurant.categories, []);
    expect(restaurant.customerReviews, []);
    expect(restaurant.menus, {});
  });

  test("getRestaurantsFromJson should return a list of Restaurant objects", () {
    final restaurants = Restaurant.getRestaurantsFromJson("""
{
  "restaurants": [
    {
    "id": "testId",
    "name": "testName",
    "description": "testDescription",
    "pictureId": "testPictureId",
    "city": "testCity",
    "rating": 1
  },
  {
    "id": "testId2",
    "name": "testName2",
    "description": "testDescription2",
    "pictureId": "testPictureId2",
    "city": "testCity2",
    "rating": 2
  }
  ] 
}
""");

    expect(restaurants[0].id, "testId");
    expect(restaurants[0].name, "testName");
    expect(restaurants[0].description, "testDescription");
    expect(restaurants[0].pictureId, "testPictureId");
    expect(restaurants[0].city, "testCity");
    expect(restaurants[0].rating, 1);

    expect(restaurants[1].id, "testId2");
    expect(restaurants[1].name, "testName2");
    expect(restaurants[1].description, "testDescription2");
    expect(restaurants[1].pictureId, "testPictureId2");
    expect(restaurants[1].city, "testCity2");
    expect(restaurants[1].rating, 2);
  });
}
