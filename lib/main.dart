import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fundamental/controllers/favorites_controller.dart';
import 'package:flutter_fundamental/controllers/reviews_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_fundamental/routes/detail.dart';
import 'package:flutter_fundamental/routes/home.dart';
import 'package:flutter_fundamental/routes/search.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController());
    Get.put(ReviewsController());
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Color.fromARGB(92, 0, 0, 0),
      ),
    );
    return MaterialApp(
      routes: {
        '/': (context) => const Home(),
        'search': (context) => const Search(),
        'detail': (context) => const Detail(),
      },
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF062006),
            onPrimary: Color(0xFF062006),
            secondary: Color(0xFF062006),
            onSecondary: Color(0xFF062006),
            error: Color(0xFF062006),
            onError: Color(0xFF062006),
            background: Color(0xFF062006),
            onBackground: Color(0xFF062006),
            surface: Color(0xFF062006),
            onSurface: Color(0xFF062006)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFf3bc58),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          elevation: 16,
          selectedItemColor: Color(0xFF062006),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFf3bc58),
        ),
      ),
    );
  }
}
