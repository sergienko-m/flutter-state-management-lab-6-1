import 'package:flutter_test/flutter_test.dart';
import 'package:state_management_practice/state/counter_state.dart';

void main() {
  late CounterState state;

  setUp(() => state = CounterState());
  tearDown(() => state.dispose());

  test('records changes with before and after values', () {
    state.increment(5);
    state.decrement(1);

    expect(state.value, 4);
    expect(state.history, hasLength(2));
    expect(state.history.first.action, '-1');
    expect(state.history.first.before, 5);
    expect(state.history.first.after, 4);
    expect(state.history.last.action, '+5');
  });

  test('does not allow negative values or history entries', () {
    state.decrement(1);
    state.increment(5);
    state.decrement(10);

    expect(state.value, 5);
    expect(state.history, hasLength(1));
  });

  test('reset records an entry only when value is not zero', () {
    state.reset();
    expect(state.history, isEmpty);

    state.increment(10);
    state.reset();

    expect(state.value, 0);
    expect(state.history.first.action, 'Скинути');
    expect(state.history.first.before, 10);
    expect(state.history.first.after, 0);
  });

  test('clearHistory empties history but keeps the value', () {
    state.increment(1);
    state.clearHistory();

    expect(state.history, isEmpty);
    expect(state.value, 1);
  });

  test('notifies listeners on change', () {
    var calls = 0;
    state.addListener(() => calls++);

    state.increment(1);
    state.clearHistory();

    expect(calls, 2);
  });
}
