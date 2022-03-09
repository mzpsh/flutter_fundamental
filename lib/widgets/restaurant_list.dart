import 'package:flutter/material.dart';
import 'package:flutter_fundamental/widgets/home_app_bar.dart';
import 'package:flutter_fundamental/widgets/home_top_bar.dart';
import 'package:flutter_fundamental/widgets/restaurant_items.dart';

class RestaurantList extends StatefulWidget {
  final AsyncSnapshot<Object?> snapshot;

  const RestaurantList({required this.snapshot, Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final _scrollController = ScrollController();

  var _appbarBackgroundColor = const Color(0x00FFFFFF);

  List<Widget> _renderSlivers(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return [
        HomeTopBar(
          data: snapshot.data,
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Error has occured.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        )
      ];
    } else if (snapshot.hasData) {
      List data = snapshot.data as List;
      return [
        HomeTopBar(
          data: data,
        ),
        HomeAppBar(backgroundColor: _appbarBackgroundColor),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => RestaurantItem(
                    restaurant: data[index],
                    index: index,
                    isHeroed: true,
                  ),
              childCount: data.length),
        )
      ];
    } else {
      return [
        const HomeTopBar(),
        HomeAppBar(backgroundColor: _appbarBackgroundColor),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => RestaurantItemSkeleton(index: index),
              childCount: 6),
        )
      ];
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 64 + 12) {
        _appbarBackgroundColor = const Color(0xFFf3bc58);
      } else {
        _appbarBackgroundColor = const Color(0x00ffffff);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: _renderSlivers(widget.snapshot),
    );
  }
}
