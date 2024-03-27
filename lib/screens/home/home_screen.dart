import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/home/home_screen_provider.dart';
import 'package:tripper/screens/home/trip_screen.dart';
import 'package:tripper/screens/home/widgets/dates_search/dates_search_tile.dart';
import 'package:tripper/screens/home/widgets/people_search/people_search_tile.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_tile.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/widgets/shimmer_overlay.dart';
import 'package:tripper/screens/widgets/tripper_crossfade_switcher.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenNotifierProvider);

    ref.listen(
      homeScreenNotifierProvider,
      (_, state) {
        state.whenData(
          (data) => data.whenOrNull(
            result: (trip) => context.push(
              '${HomeScreen.routeName}/${TripScreen.routeName}',
              extra: {'trip': trip},
            ),
            error: (message) => showSnackBar(context, message),
          ),
        );
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.l, horizontal: Dimensions.m),
        child: TripperCrossfadeSwitcher(
          child: state.when(
            data: (data) => data.when(
              init: () => const _SearchContent(),
              result: (trip) => const _SearchContent(),
              error: (_) => const _SearchContent(),
            ),
            loading: () => const _SearchContent(),
            error: (_, __) => const _SearchContent(),
          ),
        ),
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PlacesSearchTile(),
            SizedBox(height: Dimensions.s),
            DatesSearchTile(),
            SizedBox(height: Dimensions.s),
            PeopleSearchTile(),
            SizedBox(height: Dimensions.l),
            SearchButton(),
          ],
        ),
      ),
    );
  }
}

class SearchButton extends ConsumerWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenNotifierProvider);

    return ShimmerOverlay(
      enabled: state.isLoading,
      child: SizedBox(
        height: Dimensions.xxxl,
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: ref.read(homeScreenNotifierProvider.notifier).triggerSearch,
          child: Text(
            context.l10n.home_search_button,
            style: TextStyle(
              color: Theme.of(context).buttonTheme.colorScheme?.primary.withOpacity(state.isLoading ? 0.5 : 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
