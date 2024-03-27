import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/home/home_screen_provider.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/widgets/shimmer_overlay.dart';

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
