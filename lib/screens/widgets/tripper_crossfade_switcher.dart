import 'package:flutter/material.dart';

class TripperCrossfadeSwitcher extends StatelessWidget {
  const TripperCrossfadeSwitcher({
    required this.child,
    this.duration,
    super.key,
  });

  final Widget child;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    const defaultDuration = Duration(milliseconds: 300);

    return AnimatedSwitcher(
      duration: duration ?? defaultDuration,
      child: child,
    );
  }
}
