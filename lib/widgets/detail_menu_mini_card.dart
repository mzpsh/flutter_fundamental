import 'package:flutter/material.dart';
import 'package:flutter_fundamental/routes/search.dart';

class MenuMiniCard extends StatelessWidget {
  final String chipText;

  const MenuMiniCard({
    required this.chipText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Search(
                searchTerm: chipText,
              ),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFf9dfbc),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              chipText.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF001000),
                    fontSize: 12,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
