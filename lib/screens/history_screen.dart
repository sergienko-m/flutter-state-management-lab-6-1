import 'package:flutter/material.dart';

import '../state/counter_scope.dart';
import '../widgets/history_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryScreen');
    final counter = CounterScope.of(context);
    final history = counter.history;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія змін'),
        actions: const [HistoryBadge()],
      ),
      body: history.isEmpty
          ? const Center(child: Text('Історія поки порожня.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${entry.after}')),
                    title: Text(entry.action),
                    subtitle: Text(
                      '${_formatDate(entry.timestamp)}\n'
                      '${entry.before} → ${entry.after}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      bottomNavigationBar: history.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: OutlinedButton.icon(
                  onPressed: counter.clearHistory,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Очистити історію'),
                ),
              ),
            ),
    );
  }

  String _formatDate(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year} '
        '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
  }
}
