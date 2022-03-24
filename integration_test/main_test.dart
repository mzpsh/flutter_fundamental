import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_fundamental/utils/daily_notification.dart';
import 'package:flutter_fundamental/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Able to load and show list of restaurant',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Melting Pot'), findsOneWidget);
    expect(find.text('Kafe Kita'), findsOneWidget);
  });

  testWidgets('Able to set scheduled notification.',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.text('Settings'));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('Daily restaurant reminder'));
    await tester.pump(const Duration(seconds: 3));

    final notificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    expect(notificationRequests.isNotEmpty, true);
  });

  testWidgets(
      'Able to set scheduled notification and cancel all notifications.',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.text('Settings'));
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('Daily restaurant reminder'));
    await tester.pump(const Duration(seconds: 5));

    // Cancelling the notifications
    await tester.tap(find.text('Daily restaurant reminder'));
    await tester.pump(const Duration(seconds: 1));

    final notificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    expect(notificationRequests.isEmpty, true);
  });
}
