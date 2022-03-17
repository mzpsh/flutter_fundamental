import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final bool isDark;
  final bool isTransparent;
  final double width, height;
  const Skeleton(
      {required this.height,
      required this.width,
      this.isDark = false,
      this.isTransparent = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isDark
                ? const Color.fromARGB(255, 226, 150, 62)
                : isTransparent
                    ? const Color(0xA0FFFFFF)
                    : const Color(0xFFf1f1f1)));
  }
}
