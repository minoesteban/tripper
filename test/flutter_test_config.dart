import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripper/screens/utils/exports.dart';

late TripperTestWidgetsFlutterBinding binding;
late L10n l10n;

final debugPrintBuffer = <String>[];

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  WidgetController.hitTestWarningShouldBeFatal = true;

  // Prevent printing to stdout (unless a test fails) ...
  binding = TripperTestWidgetsFlutterBinding();
  setUp(() async {
    debugPrintBuffer.clear();
    SharedPreferences.setMockInitialValues({});
  });

  l10n = await L10n.delegate.load(defaultLocale);
  await loadAppFonts();

  return testMain();
}

class TripperTestWidgetsFlutterBinding extends AutomatedTestWidgetsFlutterBinding {
  TripperTestWidgetsFlutterBinding() {
    showAppDumpInErrors = true;
  }

  // Return `false` here, if you want to have goldens with correct shadows.
  //
  // Unfortunately we can't do this for our automated visual tests,
  // because they become flaky with disableShadows => false.
  @override
  bool get disableShadows => false;

  @override
  void initInstances() {
    super.initInstances();
    FlutterErrorDetails.propertiesTransformers.add(dumpTextWidgetsTransformer);
  }

  @override
  DebugPrintCallback get debugPrintOverride => onlyPrintOnError;
}

Iterable<DiagnosticsNode> dumpTextWidgetsTransformer(Iterable<DiagnosticsNode> properties) sync* {
  for (final property in properties) {
    if (property is DiagnosticsProperty &&
        property.name == 'At the time of the failure, the widget tree looked as follows') {
      String? textDump;
      try {
        // ignore: avoid_dynamic_calls
        (property.value.value as RenderObjectToWidgetElement).visitChildren((child) {
          textDump = dumpText(child);
        });
      } catch (error) {
        // Ignored.
      }
      if (textDump != null) {
        yield DiagnosticsProperty('At the time of the failure, the following text was present', textDump);
      }
    } else {
      yield property;
    }
  }
}

String dumpText(Element root) {
  final sb = StringBuffer();

  void handleNode(DiagnosticsNode node) {
    final value = node.value;
    if (value is RenderObjectElement) {
      final widget = value.widget;
      if (widget is RichText) {
        final text = widget.text;
        // Ignore icons ...
        if (text.style?.fontFamily != 'MaterialIcons') {
          sb.writeln(text.toPlainText());
        }
      }
    }
  }

  void visit(DiagnosticsNode node) {
    handleNode(node);
    node.getChildren().forEach(visit);
  }

  visit(root.toDiagnosticsNode());
  return sb.toString();
}

void onlyPrintOnError(String? message, {int? wrapWidth}) {
  if (StackTrace.current.toString().contains('dumpErrorToConsole')) {
    debugPrintBuffer.forEach(debugPrintSynchronously);
    debugPrintSynchronously(message);
  } else {
    debugPrintBuffer.add(message ?? '');
  }
}
