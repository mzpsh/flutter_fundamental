import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const HomeTopBar({
    this.data,
    Key? key,
  }) : super(key: key);

  void _showNoDataAlert(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search'),
            content: const Text('Error has occured.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 52),
                  child: Image.asset(
                    'assets/images/header.png',
                    height: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                    onPressed: () {
                      if (data == null) {
                        _showNoDataAlert(context);
                      } else {
                        Navigator.pushNamed(context, 'search', arguments: data);
                      }
                    },
                    icon: const Icon(Icons.search)),
              )
            ],
          )),
    );
  }
}
