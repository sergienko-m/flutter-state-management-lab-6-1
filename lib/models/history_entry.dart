import 'package:flutter/foundation.dart';

/// Незмінний запис в історії лічильника.
@immutable
class HistoryEntry {
  const HistoryEntry({
    required this.timestamp,
    required this.action,
    required this.before,
    required this.after,
  });

  final DateTime timestamp;
  final String action;
  final int before;
  final int after;
}
