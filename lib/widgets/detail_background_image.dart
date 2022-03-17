import 'package:flutter/material.dart';

class DetailBackgroundImage extends StatelessWidget {
  const DetailBackgroundImage({
    Key? key,
    required this.pictureId,
  }) : super(key: key);

  final String pictureId;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 224,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://restaurant-api.dicoding.dev/images/medium/$pictureId')),
      ),
    );
  }
}
