import 'package:flutter/material.dart';

class HistoryBadge extends StatelessWidget {
  const HistoryBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryBadge');
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Center(
        child: Badge(
          label: Text('$count'),
          child: const Icon(Icons.history),
        ),
      ),
    );
  }
}
