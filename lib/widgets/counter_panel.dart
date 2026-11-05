import 'package:flutter/material.dart';

class CounterPanel extends StatefulWidget {
  const CounterPanel({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    super.key,
  });

  final int value;
  final ValueChanged<int> onIncrement;
  final ValueChanged<int> onDecrement;
  final VoidCallback onReset;

  @override
  State<CounterPanel> createState() => _CounterPanelState();
}

class _CounterPanelState extends State<CounterPanel> {
  // Ефемерний стан: крок стосується лише цієї панелі.
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterPanel');
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Поточне значення', style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                '${widget.value}',
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 28),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment<int>(value: 1, label: Text('Крок 1')),
                  ButtonSegment<int>(value: 5, label: Text('Крок 5')),
                  ButtonSegment<int>(value: 10, label: Text('Крок 10')),
                ],
                selected: <int>{_step},
                onSelectionChanged: (selection) {
                  setState(() => _step = selection.first);
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'decrement',
                    onPressed: widget.value >= _step
                        ? () => widget.onDecrement(_step)
                        : _showNonNegativeMessage,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 24),
                  FloatingActionButton(
                    heroTag: 'increment',
                    onPressed: () => widget.onIncrement(_step),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: widget.value == 0 ? null : widget.onReset,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Скинути'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNonNegativeMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Значення не може бути від’ємним: '
          'при поточному значенні та кроці віднімати не можна.',
        ),
      ),
    );
  }
}
