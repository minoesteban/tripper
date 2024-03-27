import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tripper/screens/home/home_screen.dart';

import 'visual_test_utils.dart';

void main() {
  visualTest(HomeScreen, (tester) async {
    await tester.startApp();

    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == l10n.signIn_signIn_action,
    ));

    await tester.pumpAndSettle();

    await tester.matchGoldenFile();
  });
}
