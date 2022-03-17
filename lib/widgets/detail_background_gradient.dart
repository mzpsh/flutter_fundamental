import 'package:flutter/material.dart';

class DetailBackgroundGradient extends StatelessWidget {
  const DetailBackgroundGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 224,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(0, 0, 0, 0),
              Color.fromARGB(0, 0, 0, 0),
              Color.fromARGB(169, 0, 0, 0)
            ],
          )),
    );
  }
}
