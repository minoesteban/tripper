import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpansionTileControllerExtended extends ExpansionTileController {
  final StreamController<bool> _streamController = StreamController<bool>.broadcast();

  Stream<bool> get stream => _streamController.stream;

  @override
  void collapse() {
    super.collapse();

    // Broadcast the collapse event to all listeners.
    _streamController.add(false);
  }

  @override
  void expand() {
    super.expand();

    // Broadcast the expand event to all listeners.
    _streamController.add(true);
  }
}

ExpansionTileControllerExtended useExpansionTileControllerExtended({List<Object?>? keys}) {
  return use(_ExpansionTileControllerExtendedHook(keys: keys));
}

class _ExpansionTileControllerExtendedHook extends Hook<ExpansionTileControllerExtended> {
  const _ExpansionTileControllerExtendedHook({List<Object?>? keys}) : super(keys: keys);

  @override
  HookState<ExpansionTileControllerExtended, Hook<ExpansionTileControllerExtended>> createState() =>
      _ExpansionTileControllerExtendedHookState();
}

class _ExpansionTileControllerExtendedHookState
    extends HookState<ExpansionTileControllerExtended, _ExpansionTileControllerExtendedHook> {
  final controller = ExpansionTileControllerExtended();

  @override
  String get debugLabel => 'useExpansionTileControllerExtended';

  @override
  ExpansionTileControllerExtended build(BuildContext context) => controller;
}
