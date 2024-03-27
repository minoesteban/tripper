import 'package:flutter_test/flutter_test.dart';
import 'package:tripper/domain/map/map_providers.dart';
import 'package:tripper/screens/map/map_screen_provider.dart';
import 'package:tripper/screens/map/map_state.dart';

import '../../mocks/map_remote_data_source_mock.dart';
import '../../utils/riverpod_utils.dart';
import '../../utils/test_utils.dart';

void main() {
  testWidgets('initializes', (tester) async {
    final container = createContainer(
      overrides: [
        mapRemoteDataSourceProvider.overrideWith((ref) => MapRemoteDataSourceMock()),
      ],
    );

    await expectLater(
      container.read(mapNotifierProvider.future),
      completion(const MapState.init()),
    );

    await extraPump(tester);
  });
}
