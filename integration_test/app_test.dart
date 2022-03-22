import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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
}
