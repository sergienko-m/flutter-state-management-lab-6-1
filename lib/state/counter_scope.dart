import 'package:flutter/widgets.dart';

import 'counter_state.dart';

/// Надає [CounterState] усьому дереву нижче. Залежні віджети
/// перебудовуються лише тоді, коли нотіфікатор сповіщає про зміну.
class CounterScope extends InheritedNotifier<CounterState> {
  const CounterScope({
    required CounterState notifier,
    required super.child,
    super.key,
  }) : super(notifier: notifier);

  static CounterState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CounterScope>();
    assert(scope != null, 'CounterScope не знайдено в дереві віджетів.');
    return scope!.notifier!;
  }
}
