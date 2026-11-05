import 'package:flutter/material.dart';

import 'models/history_entry.dart';
import 'screens/counter_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const CounterApp());
}

/// Етап 1: спільний предок обох екранів. Тут живуть значення та історія,
/// вниз вони передаються конструкторами, а вгору зміни йдуть колбеками.
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _value = 0;
  final List<HistoryEntry> _history = <HistoryEntry>[];
  bool _historyOpen = false;

  void _record(String action, int after) {
    final before = _value;
    setState(() {
      _history.insert(
        0,
        HistoryEntry(
          timestamp: DateTime.now(),
          action: action,
          before: before,
          after: after,
        ),
      );
      _value = after;
    });
  }

  void _increment(int step) => _record('+$step', _value + step);

  void _decrement(int step) {
    if (_value - step < 0) {
      return;
    }
    _record('-$step', _value - step);
  }

  void _reset() {
    if (_value == 0) {
      return;
    }
    _record('Скинути', 0);
  }

  void _clearHistory() {
    if (_history.isEmpty) {
      return;
    }
    setState(_history.clear);
  }

  void _setHistoryOpen(bool open) {
    setState(() => _historyOpen = open);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterApp');
    return MaterialApp(
      title: 'Лічильник з історією',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Екран історії не відкривається через Navigator.push: маршрут
      // захопив би застарілі дані. Тому на етапі 1 екрани перемикаються
      // тут, у спільному предку.
      home: PopScope(
        canPop: !_historyOpen,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _setHistoryOpen(false);
          }
        },
        child: _historyOpen
            ? HistoryScreen(
                history: _history,
                onClear: _clearHistory,
                onBack: () => _setHistoryOpen(false),
              )
            : CounterScreen(
                value: _value,
                historyCount: _history.length,
                onIncrement: _increment,
                onDecrement: _decrement,
                onReset: _reset,
                onOpenHistory: () => _setHistoryOpen(true),
              ),
      ),
    );
  }
}
