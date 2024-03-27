import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tripper/main.dart';
import 'package:tripper/screens/splash/splash_screen.dart';

export '../flutter_test_config.dart';

const allDevices = [
  Device(name: 'mobile', size: Size(375, 667)),
  // Device(name: 'tablet', size: Size(1180, 820)),
];

/// Test matrix to define which flavors and which devices should be used for a visual test.
class TestConfig {
  TestConfig({
    this.devices = const [],
    this.autoHeight = false,
  });

  factory TestConfig.withDevices(List<Device> devices) => TestConfig(
        devices: devices,
      );

  factory TestConfig.autoHeight(List<Device> devices) => TestConfig(
        devices: devices,
        autoHeight: true,
      );

  final List<Device> devices;
  final bool autoHeight;
}

late List<Device> _selectedDevices;
late String _nameOfCurrentVisualTest;
late String _defaultGoldenFileName;
late bool _autoHeight;
bool _matchGoldenFileCalled = false;
bool _defaultGoldenFileNameUsed = false;

void visualTest(
  Object widgetTypeOrDescription,
  VisualTestCallback callback, {
  TestConfig? testConfig,
  DateTime? dateTimeOverride,
  bool? skip,
}) {
  final fixedClock = Clock.fixed(dateTimeOverride ?? DateTime(2023, 09, 21));
  final runTestConfig = testConfig ?? TestConfig.autoHeight(allDevices);
  testGoldens('$widgetTypeOrDescription (mock)', (tester) async {
    await withClock(fixedClock, () async {
      _autoHeight = runTestConfig.autoHeight;
      _selectedDevices = (runTestConfig.devices.isEmpty ? allDevices : runTestConfig.devices).toList();
      _nameOfCurrentVisualTest = widgetTypeOrDescription.toString();

      _defaultGoldenFileName = _nameOfCurrentVisualTest
          .replaceAllMapped(RegExp('(?<=[a-z])[A-Z]'), (match) => '_${match.group(0)}')
          .replaceAll(' ', '_')
          .toLowerCase();
      _matchGoldenFileCalled = false;
      _defaultGoldenFileNameUsed = false;
      final onError = FlutterError.onError;
      FlutterError? overflowError;
      FlutterError.onError = (details) {
        final exception = details.exception;
        if (exception is FlutterError && exception.toString().startsWith('A RenderFlex overflowed')) {
          // We ignore the overflow error here (so that screenshots are recorded) and throw it later ...
          overflowError = exception;
        } else {
          onError?.call(details);
        }
      };
      try {
        await callback(tester);
        if (!_matchGoldenFileCalled) {
          throw AssertionError('matchGoldenFile(...) was not called by the visual test');
        }
      } finally {
        FlutterError.onError = onError;
        await tester.binding.setSurfaceSize(null);
        tester.platformDispatcher.clearAllTestValues();
        tester.view.reset();
      }
      if (overflowError != null) {
        throw overflowError!;
      }
    });
  }, tags: 'visual', skip: skip);
}

extension StartAppExtension on WidgetTester {
  Future<void> startApp<T extends Object>({
    String? initialPath,
    List<Override> overrides = const [],
  }) async {
    final initialRoute = initialPath ?? SplashScreen.routeName;

    await pumpWidgetBuilder(
      ProviderScope(
        overrides: overrides,
        child: TripperApp(
          initialPath: initialRoute,
        ),
      ),
      // pumpWidgetBuilder by default adds it's own MaterialApp over child we pass, this code disables it
      wrapper: (widget) => widget,
    );

    await pumpAndSettle();

    await loadImages();
  }

  Future<void> loadImages() async {
    // See https://github.com/flutter/flutter/issues/38997#issuecomment-524992589
    // and https://github.com/eBay/flutter_glove_box/blob/master/packages/golden_toolkit/lib/src/testing_tools.dart ...
    final imageElements = find.byType(Image, skipOffstage: false).evaluate();
    final containerElements = find.byType(DecoratedBox, skipOffstage: false).evaluate();
    await runAsync(() async {
      for (final imageElement in imageElements) {
        final widget = imageElement.widget;
        if (widget is Image) {
          await precacheImage(widget.image, imageElement);
        }
      }
      for (final container in containerElements) {
        final widget = container.widget as DecoratedBox;
        final decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          if (decoration.image != null) {
            await precacheImage(decoration.image!.image, container);
          }
        }
      }
    });
    await pumpAndSettle();
  }

  Future<void> matchGoldenFile([String? fileNamePrefix]) async {
    if (fileNamePrefix == null) {
      if (_defaultGoldenFileNameUsed) {
        throw AssertionError(
          'You need to call matchGoldenFile with an argument if you call it multiple times in a single visual test',
        );
      }
      _defaultGoldenFileNameUsed = true;
      // ignore: parameter_assignments
      fileNamePrefix = _defaultGoldenFileName;
    }
    _matchGoldenFileCalled = true;
    final fileName = fileNamePrefix;

    await multiScreenGolden(
      this,
      fileName,
      devices: _selectedDevices,
      autoHeight: _autoHeight,
    );
  }
}

typedef VisualTestCallback = Future<void> Function(WidgetTester widgetTester);
