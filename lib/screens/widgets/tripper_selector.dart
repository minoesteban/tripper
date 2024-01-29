import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripperSelector<T> extends StatelessWidget {
  const TripperSelector({
    required this.notifier,
    required this.items,
    this.onChanged,
    super.key,
  });

  final ValueNotifier<T> notifier;
  final Map<T, String> items;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).buttonTheme.colorScheme;

    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, _) => CupertinoSlidingSegmentedControl<T>(
        groupValue: value,
        thumbColor: colorScheme!.onPrimaryContainer,
        backgroundColor: colorScheme.background,
        children: items.map(
          (type, label) => MapEntry(
            type,
            Text(
              label,
              style: value == type ? TextStyle(color: colorScheme.background) : null,
            ),
          ),
        ),
        onValueChanged: (type) {
          onChanged?.call();
          notifier.value = type as T;
        },
      ),
    );
  }
}
