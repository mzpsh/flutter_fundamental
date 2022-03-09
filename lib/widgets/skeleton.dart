import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double width, height;
  const Skeleton({required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFFF1F1F1)),
    );
  }
}
