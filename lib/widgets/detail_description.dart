import '../models/restaurant.dart';
import 'package:flutter/material.dart';

class DetailDescription extends StatefulWidget {
  final Restaurant restaurant;
  const DetailDescription({required this.restaurant, Key? key})
      : super(key: key);

  @override
  _DetailDescriptionState createState() => _DetailDescriptionState();
}

class _DetailDescriptionState extends State<DetailDescription> {
  bool _isDescriptionOpen = false;

  @override
  Widget build(BuildContext context) {
    Widget renderCategories() {
      List categories = [];
      for (Map item in widget.restaurant.categories) {
        categories.add(item['name']);
      }
      return Text('Categories: ${categories.join(", ")}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.bold,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    renderCategories(),
                    Text(
                      '    ' + widget.restaurant.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: const Color(0xFF001000),
                          ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink())
      ],
    );
  }
}
