import 'package:flutter/material.dart';
import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:flutter_fundamental/widgets/restaurant_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          height: 160,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFf3bc58), Color(0xFFf6a546)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        FutureBuilder(
          future: Restaurant.getLocalRestaurants(
              'assets/jsons/local_restaurants.json'),
          builder: (context, snapshot) {
            return RestaurantList(snapshot: snapshot);
          },
        )
      ],
    );
  }
}
