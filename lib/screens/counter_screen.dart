import 'package:flutter/material.dart';

import '../widgets/counter_panel.dart';
import '../widgets/history_badge.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({
    required this.value,
    required this.historyCount,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    required this.onOpenHistory,
    super.key,
  });

  final int value;
  final int historyCount;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final VoidCallback onReset;
  final VoidCallback onOpenHistory;

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник'),
        actions: [
          IconButton(
            tooltip: 'Історія змін',
            onPressed: onOpenHistory,
            icon: HistoryBadge(count: historyCount),
          ),
        ],
      ),
      body: CounterPanel(
        value: value,
        onIncrement: onIncrement,
        onDecrement: onDecrement,
        onReset: onReset,
      ),
    );
  }
}
