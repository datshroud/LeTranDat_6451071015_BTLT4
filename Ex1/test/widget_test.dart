import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ex1/main.dart';

void main() {
  testWidgets('Register button is disabled initially', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RegisterApp());

    final registerButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Dang ky'),
    );

    expect(registerButton.onPressed, isNull);
  });
}
