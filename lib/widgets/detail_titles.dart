import 'package:flutter/material.dart';
import 'package:flutter_fundamental/models/restaurant.dart';

class DetailTitles extends StatelessWidget {
  const DetailTitles({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            overflow: TextOverflow.fade,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurant.city,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
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
                restaurant.rating.toString(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                restaurant.categories.map((e) => e['name']).join(', '),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
