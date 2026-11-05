import 'package:flutter/foundation.dart';

import '../models/history_entry.dart';

/// Стан застосунку: значення лічильника та історія змін.
class CounterState extends ChangeNotifier {
  int _value = 0;
  final List<HistoryEntry> _history = <HistoryEntry>[];

  int get value => _value;

  /// Записи від новіших до старіших.
  List<HistoryEntry> get history => List<HistoryEntry>.unmodifiable(_history);

  int get historyCount => _history.length;

  void increment(int step) => _record('+$step', _value + step);

  void decrement(int step) {
    if (_value - step < 0) {
      return;
    }
    _record('-$step', _value - step);
  }

  void reset() {
    if (_value == 0) {
      return;
    }
    _record('Скинути', 0);
  }

  void clearHistory() {
    if (_history.isEmpty) {
      return;
    }
    _history.clear();
    notifyListeners();
  }

  void _record(String action, int after) {
    final before = _value;
    _value = after;
    _history.insert(
      0,
      HistoryEntry(
        timestamp: DateTime.now(),
        action: action,
        before: before,
        after: after,
      ),
    );
    notifyListeners();
  }
}
