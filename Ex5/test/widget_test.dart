import 'package:flutter_test/flutter_test.dart';

import 'package:ex5/main.dart';

void main() {
  testWidgets('Job application form renders required controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const JobApplicationApp());

    expect(find.text('Lê Trần Đạt - 6451071015'), findsOneWidget);
    expect(find.text('Ho va ten'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Chon tep CV'), findsOneWidget);
    expect(find.text('Nop ho so'), findsOneWidget);
  });
}
