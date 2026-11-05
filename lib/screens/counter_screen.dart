import 'package:flutter/material.dart';

import '../widgets/counter_panel.dart';
import '../widgets/history_badge.dart';
import 'history_screen.dart';

/// Не читає [CounterScope]: сам екран не залежить від стану,
/// тому не перебудовується при зміні лічильника.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник'),
        actions: [
          IconButton(
            tooltip: 'Історія змін',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const HistoryScreen()),
              );
            },
            icon: const HistoryBadge(),
          ),
        ],
      ),
      body: const CounterPanel(),
    );
  }
}
