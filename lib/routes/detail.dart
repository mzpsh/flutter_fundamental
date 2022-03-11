import 'package:flutter/material.dart';
import 'package:flutter_fundamental/models/restaurant.dart';

import '../widgets/more_restaurant_list.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _isDescriptionOpen = false;

  List<Widget> _renderMenuChips(Restaurant restaurant, String menuType) {
    List<Widget> foodsDrinks = [];

    var foods = restaurant.menus['foods'];
    var drinks = restaurant.menus['drinks'];

    if (menuType == 'food') {
      for (Map food in foods) {
        foodsDrinks.add(MenuChips(
          chipText: food['name'],
        ));
      }
    }

    if (menuType == 'drink') {
      for (Map drink in drinks) {
        foodsDrinks.add(MenuChips(
          chipText: drink['name'],
        ));
      }
    }

    return foodsDrinks;
  }

  @override
  Widget build(BuildContext context) {
    final Map _arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final _index = _arguments['index'];
    final _restaurant = _arguments['restaurant'] as Restaurant;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFf3bc58),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Favorite'),
                  content: const Text('Not implemented yet.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'))
                  ],
                );
              });
        },
        child: const Icon(Icons.favorite),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'image$_index',
                  child: Material(
                    child: Stack(
                      children: [
                        Ink(
                          height: 224,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_restaurant.pictureId),
                            ),
                          ),
                        ),
                        Container(
                          height: 224,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(169, 0, 0, 0)
                                ],
                              )),
                        ),
                        Positioned(
                          bottom: 24,
                          left: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _restaurant.name,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _restaurant.city,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  Text(
                                    _restaurant.rating.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: Text(
                    'FOODS AND DRINKS',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
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
                      ..._renderMenuChips(_restaurant, 'drink')
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
                      ..._renderMenuChips(_restaurant, 'food')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isDescriptionOpen = !_isDescriptionOpen;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 18, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'WORDS AND SENTENCES',
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: const Color(0xFF062006),
                                    ),
                          ),
                          Icon(_isDescriptionOpen
                              ? Icons.expand_less
                              : Icons.expand_more)
                        ],
                      )),
                ),
                (_isDescriptionOpen
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Text(
                          '    ' + _restaurant.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                    color: const Color(0xFF001000),
                                  ),
                        ),
                      )
                    : const SizedBox.shrink()),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: Text(
                    'MORE RESTAURANTS',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: const Color(0xFF062006),
                        ),
                  ),
                ),
                FutureBuilder(
                  future: Restaurant.getLocalRestaurants(
                      'assets/jsons/local_restaurants.json'),
                  builder: (context, snapshot) {
                    return MoreRestaurantList(
                        snapshot: snapshot, currentRestaurant: _restaurant);
                  },
                )
              ],
            ),
          ),
          const BackButton(),
        ],
      ),
    );
  }
}

class MenuChips extends StatelessWidget {
  final String chipText;

  const MenuChips({
    required this.chipText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(90),
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFf9dfbc),
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: Color.fromARGB(255, 10, 9, 7), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              chipText.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF001000),
                    fontSize: 12,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      left: 12,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: Color(0x80000000)),
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
