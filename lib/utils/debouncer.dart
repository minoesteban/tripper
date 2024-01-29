import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Debouncer {
  Debouncer(this.duration);

  final Duration duration;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}

Debouncer useDebouncer(Duration duration, {List<Object?>? keys}) {
  return use(_DebouncerHook(duration: duration, keys: keys));
}

class _DebouncerHook extends Hook<Debouncer> {
  const _DebouncerHook({
    required this.duration,
    super.keys,
  });

  final Duration duration;

  @override
  HookState<Debouncer, Hook<Debouncer>> createState() => _DebouncerHookState();
}

class _DebouncerHookState extends HookState<Debouncer, _DebouncerHook> {
  late final controller = Debouncer(hook.duration);

  @override
  String get debugLabel => 'useDebouncer';

  @override
  Debouncer build(BuildContext context) => controller;

  @override
  void dispose() {}
}
