import 'package:flutter/material.dart';
import 'package:flutter_fundamental/widgets/restaurant_items.dart';
import '../models/restaurant.dart';

class MoreRestaurantList extends StatefulWidget {
  final Restaurant currentRestaurant;
  final AsyncSnapshot<Object?> snapshot;

  const MoreRestaurantList(
      {required this.snapshot, required this.currentRestaurant, Key? key})
      : super(key: key);

  @override
  State<MoreRestaurantList> createState() => _MoreRestaurantListState();
}

class _MoreRestaurantListState extends State<MoreRestaurantList> {
  List<Widget> _renderList(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return [
        Center(
          child: Text(
            'Error has occured.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ];
    } else if (snapshot.hasData) {
      List data = snapshot.data as List;
      List _filteredData = [];
      for (Restaurant restaurant in data) {
        if (!(restaurant.id == widget.currentRestaurant.id)) {
          _filteredData.add(restaurant);
        }
      }

      List<Widget> restaurantWidgets = [];

      for (var i = 0; i < _filteredData.length; i++) {
        restaurantWidgets.add(RestaurantItem(
          index: i,
          restaurant: _filteredData[i],
        ));
      }

      return restaurantWidgets;
    } else {
      List<Widget> restaurantSkeletonWidgets = [];
      for (var i = 0; i < 6; i++) {
        restaurantSkeletonWidgets.add(RestaurantItemSkeleton(index: i));
      }
      return restaurantSkeletonWidgets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _renderList(widget.snapshot),
    );
  }
}
