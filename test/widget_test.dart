
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recogenie/core/routing/app_routing.dart';
import 'package:recogenie/main.dart';

void main() {
  // Bind the test framework to the Flutter engine
  TestWidgetsFlutterBinding.ensureInitialized();


  // Your test case
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp(appRouter: AppRouts(),));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
