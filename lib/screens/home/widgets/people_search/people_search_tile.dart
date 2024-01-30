import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/home/widgets/people_search/people_search_provider.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/widgets/tripper_button.dart';
import 'package:tripper/screens/widgets/tripper_expansion_tile.dart';

class PeopleSearchTile extends HookConsumerWidget {
  const PeopleSearchTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(peopleSearchNotifierProvider);

    final controller = useExpansionTileController();
    final isPeopleSet = useValueNotifier(false);

    final numberOfAdults = useValueNotifier(1);
    final numberOfChildren = useValueNotifier(0);
    final numberOfInfants = useValueNotifier(0);

    ref.listen(
      peopleSearchNotifierProvider,
      (_, state) => state.whenData(
        (data) => data.whenOrNull(
          set: (_, __, ___) {
            controller.collapse();
          },
          error: (message) => showSnackBar(context, message),
        ),
      ),
    );

    final labelColor = Theme.of(context).inputDecorationTheme.hintStyle!.color!;

    final defaultLabel = Text(
      context.l10n.home_people_hint,
      style: TripperStyles.labelSmall.copyWith(
        color: labelColor.withOpacity(.5),
      ),
    );

    return TripperExpansionTile(
      controller: controller,
      onExpansionChanged: (isExpanded) => isPeopleSet.value = !isExpanded,
      title: state.maybeWhen(
        data: (data) => data.maybeMap(
          set: (set) {
            return Text(
              set.description,
              style: TripperStyles.labelSmall.copyWith(color: labelColor),
            );
          },
          orElse: () => defaultLabel,
        ),
        orElse: () => defaultLabel,
      ),
      icon: Icons.people_alt_rounded,
      children: [
        PeopleSelectionTile(
          title: context.l10n.home_people_adults_title,
          subtitle: context.l10n.home_people_adults_subtitle,
          numberOfPeople: numberOfAdults,
        ),
        PeopleSelectionTile(
          title: context.l10n.home_people_children_title,
          subtitle: context.l10n.home_people_children_subtitle,
          numberOfPeople: numberOfChildren,
        ),
        PeopleSelectionTile(
          title: context.l10n.home_people_infants_title,
          subtitle: context.l10n.home_people_infants_subtitle,
          numberOfPeople: numberOfInfants,
        ),
        const SizedBox(height: Dimensions.m),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.m),
            child: TripperButton(
              text: context.l10n.home_date_confirm,
              onPressed: () {
                ref.read(peopleSearchNotifierProvider.notifier).setPeople(
                      numberOfAdults.value,
                      numberOfChildren.value,
                      numberOfInfants.value,
                    );
              },
            ),
          ),
        ),
        const SizedBox(height: Dimensions.m),
      ],
    );
  }
}

class PeopleSelectionTile extends StatelessWidget {
  const PeopleSelectionTile({
    required this.title,
    required this.subtitle,
    required this.numberOfPeople,
    super.key,
  });

  final String title;
  final String subtitle;
  final ValueNotifier<int> numberOfPeople;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TripperStyles.labelSmall,
      ),
      subtitle: Text(
        subtitle,
        style: TripperStyles.labelXSmall.copyWith(
          color: Theme.of(context).inputDecorationTheme.hintStyle!.color!.withOpacity(.5),
        ),
      ),
      contentPadding: const EdgeInsets.only(left: Dimensions.m),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (numberOfPeople.value > 0) {
                numberOfPeople.value--;
              }
            },
            icon: const Icon(Icons.remove_circle_outline_rounded),
          ),
          ValueListenableBuilder<int>(
            valueListenable: numberOfPeople,
            builder: (context, number, _) {
              return Text(
                '$number',
                style: TripperStyles.labelSmall,
              );
            },
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => numberOfPeople.value++,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
    );
  }
}
