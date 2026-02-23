import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

void main() {
  testWidgets('Todo app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    await tester.pumpAndSettle();

    // Verify app title and list items
    expect(find.text('My Tasks'), findsWidgets);
    expect(find.text('Design System'), findsOneWidget);
    expect(find.text('User Testing'), findsOneWidget);
  });
}
