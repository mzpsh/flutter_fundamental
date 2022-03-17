import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.fromLTRB(24, 24, 12, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Image.asset(
                  'assets/images/header.png',
                  height: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, 'search'),
                  icon: const Icon(Icons.search)),
            )
          ],
        ));
  }
}
