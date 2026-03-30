import 'package:flutter_test/flutter_test.dart';

import 'package:ex2/main.dart';

void main() {
  testWidgets('Personal info form renders required fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PersonalInfoApp());

    expect(find.text('Lê Trần Đạt - 6451071015'), findsOneWidget);
    expect(find.text('Ho va ten'), findsOneWidget);
    expect(find.text('Tuoi'), findsOneWidget);
    expect(find.text('Gioi tinh'), findsOneWidget);
    expect(find.text('Luu thong tin'), findsOneWidget);
  });
}
