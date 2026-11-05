import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_practice/main.dart';

void main() {
  testWidgets('increment updates value and badge', (tester) async {
    await tester.pumpWidget(const CounterApp());
    expect(find.text('Поточне значення'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Одна «1» — значення, друга — бейдж історії.
    expect(find.text('1'), findsNWidgets(2));
  });

  testWidgets('decrement at zero shows an explanation', (tester) async {
    await tester.pumpWidget(const CounterApp());

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.textContaining('не може бути від’ємним'), findsOneWidget);
  });
}
