import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_demo/main.dart';

void main() {
  testWidgets('App renders dashboard and displays title', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const StateManagementDemoApp());
    await tester.pumpAndSettle();

    // Verify Dashboard title exists
    expect(find.text('State Management Demo'), findsWidgets);
    expect(find.text('State & Counter'), findsWidgets);
  });
}
