import 'package:flutter_test/flutter_test.dart';
import 'package:mypf/main.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Piyush Singh'), findsWidgets);
  });
}