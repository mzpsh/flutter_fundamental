import 'package:flutter/material.dart';
import 'package:flutter_fundamental/controllers/favorites_controller.dart';
import 'package:flutter_fundamental/utils/daily_notification.dart';
import 'package:flutter_fundamental/utils/restaurant_getter.dart';
import 'package:flutter_fundamental/widgets/restaurant_items.dart';
import 'package:flutter_fundamental/widgets/restaurant_list.dart';
import 'package:get/get.dart';

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
          : _tabIndex == 1
              ? FavoriteTab()
              : const SettingsTab(),
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
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const ReminderSwitch(),
    );
  }
}

class ReminderSwitch extends StatefulWidget {
  const ReminderSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderSwitch> createState() => _ReminderSwitchState();
}

class _ReminderSwitchState extends State<ReminderSwitch> {
  bool _isActive = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    void toggle() async {
      _isLoading = true;
      setState(() {});
      var status =
          await DailyNotification.switchNotification(context, !_isActive);
      _isLoading = false;
      _isActive = status;
      setState(() {});
    }

    return InkWell(
      onTap: toggle,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily restaurant reminder',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircularProgressIndicator(),
                  )
                : Switch(
                    activeColor: const Color.fromARGB(255, 21, 112, 21),
                    value: _isActive,
                    onChanged: (value) {
                      toggle();
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class FavoriteTab extends StatelessWidget {
  final FavoritesController c = Get.find();

  FavoriteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            future: RestaurantGetter.getRestaurantsFromAPI(),
            builder: (context, snapshot) {
              return RestaurantList(snapshot: snapshot);
            },
          ),
        )
      ],
    );
  }
}
