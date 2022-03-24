import 'package:flutter_fundamental/utils/daily_notification.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_fundamental/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// This is for rejected submission 1073244
  /// testWidgets used instead of test is to
  /// overcome flutter_native_timezone limitation.
  /// The test runs in real device instead of
  /// mocked environment.
  testWidgets('nextElevenAM should return a non UTC, true local time.',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final time = await DailyNotification.nextElevenAM();

    expect(time.isUtc, false);
    expect(time.isLocal, true);
  });
}
