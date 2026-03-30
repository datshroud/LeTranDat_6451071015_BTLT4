import 'package:flutter_test/flutter_test.dart';

import 'package:ex3/main.dart';

void main() {
  testWidgets('Survey form renders required controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SurveyApp());

    expect(find.text('Lê Trần Đạt - 6451071015'), findsOneWidget);
    expect(find.text('So thich'), findsOneWidget);
    expect(find.text('Muc do hai long'), findsOneWidget);
    expect(find.text('Ghi chu them'), findsOneWidget);
    expect(find.text('Gui khao sat'), findsOneWidget);
  });
}
