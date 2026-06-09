import 'package:flutter_test/flutter_test.dart';
import 'package:zenfocus_ai/main.dart';

void main() {
  testWidgets('ZenFocus app launches successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ZenFocusApp());
    expect(find.byType(ZenFocusApp), findsOneWidget);
  });
}
