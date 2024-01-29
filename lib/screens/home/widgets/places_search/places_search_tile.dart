import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/domain/map/point_of_interest.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_provider.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/utils/styles.dart';

class PlacesSearchTile extends HookConsumerWidget {
  const PlacesSearchTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useSearchController();
    final selectedPlace = useValueNotifier<PointOfInterest?>(null);

    useEffect(() {
      void listener() {
        if (selectedPlace.value != null) {
          controller.text = selectedPlace.value!.name;
        }
      }

      selectedPlace.addListener(listener);

      return () => selectedPlace.removeListener(listener);
    });

    useEffect(() {
      Future<void> listener() async {
        if (controller.text.isNotEmpty && controller.isOpen) {
          await ref.read(placesSearchNotifierProvider.notifier).search(controller.text);
        }
      }

      controller.addListener(listener);

      return () => controller.removeListener(listener);
    });

    final maxWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.xs, vertical: Dimensions.xs),
      child: SearchAnchor(
        isFullScreen: false,
        viewConstraints: BoxConstraints(
          maxWidth: maxWidth - Dimensions.xl,
          maxHeight: 300,
        ),
        viewTrailing: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            color: Theme.of(context).primaryIconTheme.color?.withOpacity(.8),
            onPressed: () {},
          ),
        ],
        viewLeading: const SizedBox.shrink(),
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        dividerColor: Theme.of(context).dividerColor,
        searchController: controller,
        builder: (context, controller) => SearchBar(
          onTap: () => controller.openView(),
          elevation: MaterialStateProperty.all(5),
          hintStyle: MaterialStateProperty.all(
            TripperStyles.labelSmall.copyWith(
              color: Theme.of(context).inputDecorationTheme.hintStyle?.color?.withOpacity(.5),
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.only(left: Dimensions.s)),
          trailing: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              color: Theme.of(context).primaryIconTheme.color?.withOpacity(.8),
              onPressed: () {},
            ),
          ],
          controller: controller,
          hintText: context.l10n.home_place_hint,
        ),
        viewBuilder: (_) => Consumer(
          builder: (context, ref, child) =>
              ref.watch(placesSearchNotifierProvider).whenOrNull(
                    data: (state) => ListView(
                      padding: EdgeInsets.zero,
                      children: state.map(
                        init: (_) => [],
                        selected: (_) => [],
                        idle: (data) => [
                          ...data.results.map(
                            (result) => ListTile(
                              title: Text(result.name, style: TripperStyles.labelSmall),
                              subtitle: result.address != null
                                  ? Text(
                                      result.address!,
                                      style: TripperStyles.labelXSmall,
                                    )
                                  : null,
                              onTap: () {
                                controller.closeView(null);
                                selectedPlace.value = result;
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) ??
              const SizedBox.shrink(),
        ),
        suggestionsBuilder: (_, controller) => [],
      ),
    );
  }
}
