import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripper/screens/home/home_screen_provider.dart';
import 'package:tripper/screens/home/widgets/dates_search/dates_search_tile.dart';
import 'package:tripper/screens/home/widgets/people_search/people_search_tile.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_tile.dart';
import 'package:tripper/screens/utils/exports.dart';

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
            error: (message) => showSnackBar(context, message),
          ),
        );
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.l, horizontal: Dimensions.m),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const PlacesSearchTile(),
                const SizedBox(height: Dimensions.s),
                const DatesSearchTile(),
                const SizedBox(height: Dimensions.s),
                const PeopleSearchTile(),
                const SizedBox(height: Dimensions.l),
                ShimmeringOverlay(
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
                      child: Text(context.l10n.home_search_button),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmeringOverlay extends StatelessWidget {
  const ShimmeringOverlay({
    required this.enabled,
    required this.child,
    super.key,
  });

  final bool enabled;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).buttonTheme.colorScheme!.onBackground;
    final highlightColor = Theme.of(context).buttonTheme.colorScheme!.primary;

    return Stack(
      children: [
        child,
        Opacity(
          opacity: 0.5,
          child: Shimmer.fromColors(
            enabled: enabled,
            period: const Duration(milliseconds: 1500),
            baseColor: baseColor.withOpacity(enabled ? 0.1 : 0),
            highlightColor: highlightColor.withOpacity(enabled ? 0.25 : 0),
            child: child,
          ),
        ),
      ],
    );
  }
}
