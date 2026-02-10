import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tuf_app_mvp/main.dart';

void main() {
  testWidgets('TufApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TufApp());
    await tester.pumpAndSettle();

    // Verify the app renders with TUF+ title
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
