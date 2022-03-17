import 'package:flutter/material.dart';
import 'package:flutter_fundamental/controllers/favorites.dart';
import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:flutter_fundamental/widgets/restaurant_items.dart';
import 'package:flutter_fundamental/widgets/restaurant_list.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FavoriteRestaurants c = Get.find();
  int _tabIndex = 0;

  void _setTabIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabIndex == 0
          ? const RestaurantTab()
          : _tabIndex == 1
              ? Scaffold(
                  appBar: AppBar(
                    title: const Text('Favorite Restaurants'),
                  ),
                  body: Obx(() {
                    final restaurants = c.favoriteRestaurants;
                    if (restaurants.isEmpty) {
                      return const Center(
                        child: Text("There's no favorite restaurant."),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: ((context, index) => RestaurantItem(
                              index: index,
                              restaurant: restaurants[index],
                            )),
                      );
                    }
                  }),
                )
              : const Center(
                  child: Text('Not yet implemented.'),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: _setTabIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class RestaurantTab extends StatelessWidget {
  const RestaurantTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink(
          height: 332,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            gradient: LinearGradient(
              colors: [Color(0xFFf3bc58), Color(0xFFf6a546)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        SafeArea(
          child: FutureBuilder(
            future: Restaurant.getRestaurantsFromAPI(),
            builder: (context, snapshot) {
              return RestaurantList(snapshot: snapshot);
            },
          ),
        )
      ],
    );
  }
}
