import 'package:flutter/material.dart';
import 'package:flutter_fundamental/widgets/restaurant_items.dart';
import '../models/restaurant.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchFieldController = TextEditingController();
  final List _filteredRestaurant = [];
  bool _isSearching = false;

  void _search(String inputText, List data) {
    _isSearching = inputText.isNotEmpty;
    final _searchTerm = inputText.toLowerCase();

    _filteredRestaurant.clear();
    // Put restaurant into filtered list, if restaurant city
    // or name matches the search term.
    for (Restaurant restaurant in data) {
      final _restaurantName = restaurant.name.toLowerCase();
      final _restaurantCity = restaurant.city.toLowerCase();

      if (_restaurantName.contains(_searchTerm) ||
          _restaurantCity.contains(_searchTerm)) {
        _filteredRestaurant.add(restaurant);
      }
    }

    setState(() {});
  }

  void _clearSearchTerm() {
    _isSearching = false;
    _searchFieldController.clear();
    _filteredRestaurant.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _data = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchFieldController,
          onChanged: (input) => _search(input, _data),
          decoration: InputDecoration(
            suffixIcon: _isSearching
                ? IconButton(
                    onPressed: () => _clearSearchTerm(),
                    icon: const Icon(Icons.clear),
                  )
                : const SizedBox.shrink(),
            border: InputBorder.none,
            hintText: 'Find restaurants..',
          ),
        ),
      ),
      body: _isSearching
          ? _filteredRestaurant.isNotEmpty
              ? ListView.builder(
                  itemCount: _filteredRestaurant.length,
                  itemBuilder: (context, index) => RestaurantItem(
                        index: index,
                        restaurant: _filteredRestaurant[index],
                        isHeroed: false,
                      ))
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.sentiment_dissatisfied,
                          size: 48,
                        ),
                        Text(
                          'No restaurants found.',
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      const Icon(Icons.edit),
                      const SizedBox(width: 6),
                      Text(
                        'Type the restaurant or city name.',
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
