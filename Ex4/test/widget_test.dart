import 'package:flutter_test/flutter_test.dart';

import 'package:ex4/main.dart';

void main() {
  testWidgets('Appointment form renders required controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AppointmentApp());

    expect(find.text('Lê Trần Đạt - 6451071015'), findsOneWidget);
    expect(find.text('Chon ngay'), findsOneWidget);
    expect(find.text('Chon gio'), findsWidgets);
    expect(find.text('Chon dich vu'), findsOneWidget);
    expect(find.text('Xac nhan dat lich'), findsOneWidget);
  });
}
