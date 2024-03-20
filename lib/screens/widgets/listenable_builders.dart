import 'package:flutter/material.dart';

class ValueListenableBuilder2<S, T> extends StatelessWidget {
  const ValueListenableBuilder2({
    required this.notifier1,
    required this.notifier2,
    required this.builder,
    this.child,
    super.key,
  });

  final ValueNotifier notifier1;
  final ValueNotifier notifier2;
  final Widget? child;

  final Widget Function(BuildContext, S, T, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier1,
      builder: (context, value1, child) => ValueListenableBuilder(
        valueListenable: notifier2,
        builder: (context, value2, child) => builder(context, value1 as S, value2 as T, child),
        child: child,
      ),
      child: child,
    );
  }
}

class ValueListenableBuilder3<S, T, U> extends StatelessWidget {
  const ValueListenableBuilder3({
    required this.notifier1,
    required this.notifier2,
    required this.notifier3,
    required this.builder,
    this.child,
    super.key,
  });

  final ValueNotifier notifier1;
  final ValueNotifier notifier2;
  final ValueNotifier notifier3;
  final Widget Function(BuildContext, S, T, U, Widget?) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier1,
      builder: (context, value1, child) => ValueListenableBuilder(
        valueListenable: notifier2,
        builder: (context, value2, child) => ValueListenableBuilder(
          valueListenable: notifier3,
          builder: (context, value3, child) => builder(context, value1 as S, value2 as T, value3 as U, child),
        ),
        child: child,
      ),
      child: child,
    );
  }
}
