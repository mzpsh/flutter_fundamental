import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final Color backgroundColor;

  const HomeAppBar({
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      pinned: true,
      stretch: true,
      expandedHeight: 64,
      flexibleSpace: const FlexibleSpaceBar(
        background: SizedBox.shrink(),
        titlePadding: EdgeInsets.fromLTRB(24, 0, 0, 16),
        title: Text(
          'Restaurants',
          style: TextStyle(color: Color(0xFF062006)),
        ),
      ),
    );
  }
}
