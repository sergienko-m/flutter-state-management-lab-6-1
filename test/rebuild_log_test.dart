import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_practice/main.dart';

void main() {
  testWidgets('only CounterPanel and HistoryBadge rebuild after +',
      (tester) async {
    final log = <String>[];
    final originalDebugPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) {
        log.add(message);
      }
    };

    try {
      await tester.pumpWidget(const CounterApp());
      final initial = List<String>.of(log);
      log.clear();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      final afterPlus = List<String>.of(log);

      // ignore: avoid_print
      print('--- initial build ---\n${initial.join('\n')}');
      // ignore: avoid_print
      print('--- after tapping + ---\n${afterPlus.join('\n')}');

      expect(afterPlus, contains('build: CounterPanel'));
      expect(afterPlus, contains('build: HistoryBadge'));
      expect(afterPlus, isNot(contains('build: CounterScreen')));
    } finally {
      debugPrint = originalDebugPrint;
    }
  });
}
