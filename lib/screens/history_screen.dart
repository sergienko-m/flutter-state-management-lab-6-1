import 'package:flutter/material.dart';

import '../models/history_entry.dart';
import '../widgets/history_badge.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    required this.history,
    required this.onClear,
    required this.onBack,
    super.key,
  });

  /// Записи від новіших до старіших.
  final List<HistoryEntry> history;
  final VoidCallback onClear;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryScreen');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Назад',
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Історія змін'),
        actions: [HistoryBadge(count: history.length)],
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
                  onPressed: onClear,
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
