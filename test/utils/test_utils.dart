import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Workaround for unhandled Timer issue https://github.com/rrousselGit/riverpod/issues/1941#issuecomment-1325256770
Future<void> extraPump(WidgetTester tester) async {
  await tester.pumpWidget(Container());
  await tester.pumpAndSettle();
}

// a generic Listener class, used to keep track of when a provider notifies its listeners
class Listener<T> extends Mock {
  void call(T? previous, T next);
}
