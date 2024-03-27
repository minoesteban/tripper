import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tripper/domain/chat/chat_providers.dart';
import 'package:tripper/screens/home/home_screen_provider.dart';
import 'package:tripper/screens/home/home_state.dart';

import '../../../mocks/chat_remote_data_source_mock.dart';
import '../../../utils/riverpod_utils.dart';
import '../../../utils/test_utils.dart';

void main() {
  final listener = Listener<AsyncValue<HomeState>>();
  testWidgets('initializes', (tester) async {
    final container = createContainer(
      overrides: [
        chatDataSourceProvider.overrideWith((ref) => ChatRemoteDataSourceMock()),
      ],
    );

    await expectLater(
      container.read(homeScreenNotifierProvider.future),
      completion(const HomeState.init()),
    );

    await extraPump(tester);
  });

  testWidgets('fails search if destination is not selected', (tester) async {
    final container = createContainer(
      overrides: [
        chatDataSourceProvider.overrideWith((ref) => ChatRemoteDataSourceMock()),
      ],
    );

    const initState = AsyncData(HomeState.init());

    const searchState = AsyncData(HomeState.error('Please select a destination'));

    container.listen(homeScreenNotifierProvider, listener, fireImmediately: true);

    await extraPump(tester);

    await container.read(homeScreenNotifierProvider.notifier).triggerSearch();

    verifyInOrder([
      () => listener(null, const AsyncLoading()),
      () => listener(const AsyncLoading(), initState),
      () => listener(initState, searchState),
    ]);
  });
}
