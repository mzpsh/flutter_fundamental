import 'package:flutter/material.dart';
import 'package:flutter_fundamental/widgets/skeleton.dart';
import 'package:flutter_fundamental/widgets/home_top_bar.dart';
import 'package:flutter_fundamental/widgets/cuisines_menu.dart';
import 'package:flutter_fundamental/widgets/restaurant_items.dart';

class RestaurantList extends StatefulWidget {
  final AsyncSnapshot<Object?> snapshot;
  final bool isSearching;

  const RestaurantList(
      {required this.snapshot, this.isSearching = false, Key? key})
      : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Widget> _renderSkeletonRestaurant() {
    List<Widget> restaurantSkeletons = [];
    for (var i = 0; i < 6; i++) {
      restaurantSkeletons.add(RestaurantItemSkeleton(index: i));
    }
    return restaurantSkeletons;
  }

  Widget _renderTopWidget(context, index) {
    final List<Widget> topWidgets = [
      const HomeTopBar(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          'CUISINES',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF062006),
              ),
        ),
      ),
      const SizedBox(
        height: 12,
      ),
      const CuisinesMenu(),
      const SizedBox(
        height: 32,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          'RESTAURANTS',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF062006),
              ),
        ),
      ),
      const SizedBox(height: 12),
    ];
    return topWidgets[index];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasError) {
      return Column(
        children: [
          const HomeTopBar(),
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
      );
    } else if (widget.snapshot.hasData) {
      final data = widget.snapshot.data as List;
      if (widget.isSearching) {
        if (data.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Restaurant not found.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => RestaurantItem(
              index: index,
              restaurant: data[index],
            ),
          );
        }
      } else {
        return ListView.builder(
          itemCount: data.length + 7,
          itemBuilder: (context, index) {
            if (index < 7) {
              return _renderTopWidget(context, index);
            } else {
              return RestaurantItem(
                  index: index - 7, restaurant: data[index - 7]);
            }
          },
        );
      }
    } else {
      if (widget.isSearching) {
        return Column(children: _renderSkeletonRestaurant());
      } else {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Skeleton(
                    height: 18,
                    width: 96,
                    isDark: true,
                  )),
              const SizedBox(
                height: 12,
              ),
              const CuisinesMenuSkeleton(),
              const SizedBox(
                height: 36,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Skeleton(
                    height: 18,
                    width: 96,
                    isDark: true,
                  )),
              const SizedBox(height: 14),
              ..._renderSkeletonRestaurant()
            ],
          ),
        );
      }
    }
  }
}
