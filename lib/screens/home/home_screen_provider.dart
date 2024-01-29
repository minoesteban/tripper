import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/screens/home/home_state.dart';

part 'home_screen_provider.g.dart';

@riverpod
class HomeScreenNotifier extends _$HomeScreenNotifier {
  @override
  Future<HomeState> build() async => const HomeState.init();

  Future<void> triggerSearch() async {}
}
