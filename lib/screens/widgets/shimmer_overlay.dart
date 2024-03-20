import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOverlay extends StatelessWidget {
  const ShimmerOverlay({
    required this.enabled,
    required this.child,
    super.key,
  });

  final bool enabled;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).buttonTheme.colorScheme!.onBackground;
    final highlightColor = Theme.of(context).buttonTheme.colorScheme!.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Stack(
        children: [
          child,
          Shimmer.fromColors(
            enabled: enabled,
            period: const Duration(milliseconds: 1000),
            baseColor: baseColor.withOpacity(enabled ? 0.0 : 0),
            highlightColor: highlightColor.withOpacity(enabled ? 0.2 : 0),
            child: child,
          ),
        ],
      ),
    );
  }
}
