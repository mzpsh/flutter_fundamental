import 'package:flutter/material.dart';
import 'package:flutter_fundamental/routes/search.dart';
import 'package:flutter_fundamental/widgets/skeleton.dart';

class CuisinesMenu extends StatelessWidget {
  const CuisinesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget renderCuisineMenu(String name, IconData icon) {
      return Material(
        elevation: 12,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(
                  searchTerm: name,
                ),
              ),
            );
          },
          child: Ink(
            height: 80,
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF0e4806),
                  size: 34,
                ),
                const SizedBox(height: 10),
                Ink(
                  padding: const EdgeInsets.all(4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: LinearGradient(colors: [
                      Color(0xFF0e4806),
                      Color(0xFF143409),
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: Center(
                    child: Text(
                      name.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          renderCuisineMenu('MODERN', Icons.fastfood),
          renderCuisineMenu('JAWA', Icons.soup_kitchen),
          renderCuisineMenu('SPANYOl', Icons.dinner_dining),
          renderCuisineMenu('ITALIA', Icons.local_pizza)
        ],
      ),
    );
  }
}

class CuisinesMenuSkeleton extends StatelessWidget {
  const CuisinesMenuSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget renderCuisineMenu() {
      return Material(
        color: Colors.transparent,
        elevation: 0,
        borderRadius: const BorderRadius.all(Radius.circular(4)),

        /// Container is needed for consistency
        /// with real(non-skeleton) widget.
        /// ignore: sized_box_for_whitespace
        child: Container(
          height: 80,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Skeleton(
                height: 40,
                width: 34,
                isDark: true,
              ),
              const SizedBox(height: 10),
              Ink(
                padding: const EdgeInsets.all(4),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: const Center(
                  child: Skeleton(
                    height: 14,
                    width: 64,
                    isDark: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          renderCuisineMenu(),
          renderCuisineMenu(),
          renderCuisineMenu(),
          renderCuisineMenu(),
        ],
      ),
    );
  }
}
