import '../models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_fundamental/utils/restaurant_getter.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class DailyNotification {
  static Future<tz.TZDateTime> nextElevenAM() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime elevenAm =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (elevenAm.isBefore(now)) {
      elevenAm = elevenAm.add(const Duration(days: 1));
    }

    return elevenAm;
  }

  static Future<bool> switchNotification(
      BuildContext context, bool isEnabled) async {
    if (isEnabled) {
      final restaurantList =
          await RestaurantGetter.getRestaurantsFromAPI() as List;
      restaurantList.shuffle(); // randooom
      final Restaurant selectedRandomRestaurant = restaurantList[0];

      NotificationHelper.initialize(
          context: context,
          restaurantId: selectedRandomRestaurant.id,
          restaurantName: selectedRandomRestaurant.name,
          pictureId: selectedRandomRestaurant.pictureId);

      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Restaurant reminder',
          selectedRandomRestaurant.name,
          await nextElevenAM(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                '1', 'daily_restaurant_reminder_1',
                channelDescription:
                    'To remind the user to such how important checking a fictional restaurant is.'),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);

      return Future.value(true);
    } else {
      flutterLocalNotificationsPlugin.cancelAll();
      return Future.value(false);
    }
  }
}

class NotificationHelper {
  static void initialize({
    required BuildContext context,
    required String restaurantId,
    required String restaurantName,
    required String pictureId,
  }) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        Navigator.pushNamed(context, 'detail',
            arguments: {'pictureId': pictureId, 'restaurantId': restaurantId});
      },
    );
  }
}
