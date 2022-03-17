import 'package:flutter/material.dart';
import 'package:flutter_fundamental/controllers/favorites.dart';
import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:flutter_fundamental/widgets/detail_background_gradient.dart';
import 'package:flutter_fundamental/widgets/detail_background_image.dart';
import 'package:flutter_fundamental/widgets/detail_description.dart';
import 'package:flutter_fundamental/widgets/detail_menu_mini_card.dart';
import 'package:flutter_fundamental/widgets/detail_titles.dart';
import 'package:flutter_fundamental/widgets/floating_back_button.dart';
import 'package:flutter_fundamental/widgets/reviews.dart';
import 'package:flutter_fundamental/widgets/skeleton.dart';
import 'package:get/get.dart';
import '../widgets/more_restaurant_list.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final FavoriteRestaurants c = Get.find();
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final pictureId = arguments['pictureId'];
    final restaurantId = arguments['restaurantId'];

    return FutureBuilder(
      future: Restaurant.getRestaurantDetailFromAPI(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                const FloatingBackButton(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Error has occured. Check your connection.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          final restaurant = snapshot.data as Restaurant;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFFf3bc58),
              onPressed: () {
                final message = c.toggleRestaurantToFavorite(restaurant);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                  duration: const Duration(seconds: 1),
                ));
              },
              child: Obx(() {
                if (!c.checkIfRestaurantHasBeenFavorited(restaurant)) {
                  return const Icon(Icons.favorite_border);
                }
                return const Icon(Icons.favorite);
              }),
            ),
            body: DetailContent(restaurant: snapshot.data as Restaurant),
          );
        } else {
          return Scaffold(
            body: DetailSkeleton(
              pictureId: pictureId,
            ),
          );
        }
      },
    );
  }
}

class DetailSkeleton extends StatelessWidget {
  final String pictureId;
  const DetailSkeleton({required this.pictureId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  DetailBackgroundImage(pictureId: pictureId),
                  const DetailBackgroundGradient(),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Skeleton(
                          height: 24,
                          width: 96,
                          isTransparent: true,
                        ),
                        SizedBox(height: 4),
                        Skeleton(
                          height: 19,
                          width: 64,
                          isTransparent: true,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Skeleton(height: 18, width: 128),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Skeleton(height: 32, width: 64),
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Skeleton(height: 32, width: 64),
              ),
              const SizedBox(
                height: 28,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 12, 18, 12),
                child: Skeleton(height: 18, width: 148),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: Skeleton(height: 18, width: 128)),
            ],
          ),
        ),
        const FloatingBackButton(),
      ],
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final restaurantId = restaurant.id;
    List<Widget> renderMenuChips(Restaurant restaurant, String menuType) {
      List<Widget> foodsDrinks = [];

      var foods = restaurant.menus['foods'];
      var drinks = restaurant.menus['drinks'];

      if (menuType == 'food') {
        for (Map food in foods) {
          foodsDrinks.add(MenuMiniCard(
            chipText: food['name'],
          ));
        }
      }

      if (menuType == 'drink') {
        for (Map drink in drinks) {
          foodsDrinks.add(MenuMiniCard(
            chipText: drink['name'],
          ));
        }
      }

      return foodsDrinks;
    }

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  DetailBackgroundImage(pictureId: restaurant.pictureId),
                  const DetailBackgroundGradient(),
                  DetailTitles(restaurant: restaurant)
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text(
                  'FOODS AND DRINKS',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF062006),
                      ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    ...renderMenuChips(restaurant, 'drink')
                  ],
                ),
              ),
              const SizedBox(height: 6),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    ...renderMenuChips(restaurant, 'food')
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              DetailDescription(restaurant: restaurant),
              Reviews(restaurantId: restaurantId),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text(
                  'MORE RESTAURANTS',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF062006),
                      ),
                ),
              ),
              FutureBuilder(
                future: Restaurant.getRestaurantsFromAPI(),
                builder: (context, snapshot) {
                  return MoreRestaurantList(
                      snapshot: snapshot, currentRestaurant: restaurant);
                },
              )
            ],
          ),
        ),
        const FloatingBackButton(),
      ],
    );
  }
}
