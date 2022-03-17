import 'package:flutter/material.dart';
import 'package:flutter_fundamental/models/restaurant.dart';
import 'package:flutter_fundamental/widgets/skeleton.dart';

class RestaurantItem extends StatelessWidget {
  final int index;
  final Restaurant restaurant;

  const RestaurantItem({
    Key? key,
    required this.index,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: index == 0
          ? const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))
          : BorderRadius.zero,
      onTap: () => Navigator.pushNamed(context, 'detail', arguments: {
        "pictureId": restaurant.pictureId,
        "restaurantId": restaurant.id,
      }),
      child: Ink(
        padding: index == 0
            ? const EdgeInsets.fromLTRB(12, 12, 12, 0)
            : const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))
              : BorderRadius.zero,
          color: Colors.white,
        ),
        child: Ink(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1.5, color: Color(0xFFF1F1F1)),
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: RestaurantItemImage(restaurant: restaurant),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 12, 12, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  restaurant.city,
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                Text(
                                  restaurant.rating.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF062006),
                                          fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 6, 0),
                          child: Icon(Icons.chevron_right))
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantItemImage extends StatelessWidget {
  const RestaurantItemImage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        height: 64,
        width: 72,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(40, 0, 0, 0),
                blurRadius: 8,
                offset: Offset(0, 4))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'),
          ),
        ),
      ),
    );
  }
}

class RestaurantItemSkeleton extends StatelessWidget {
  final int index;

  const RestaurantItemSkeleton({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: index == 0
          ? const EdgeInsets.fromLTRB(12, 12, 12, 0)
          : const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: index == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))
            : BorderRadius.zero,
        color: Colors.white,
      ),
      child: Ink(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 1.5, color: Color(0xFFF1F1F1)),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Skeleton(height: 64, width: 72),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Skeleton(height: 18, width: 128),
                            SizedBox(height: 7),
                            Skeleton(height: 14, width: 40)
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Skeleton(height: 16, width: 24)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 14, 8, 0),
                    child: Skeleton(height: 20, width: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
