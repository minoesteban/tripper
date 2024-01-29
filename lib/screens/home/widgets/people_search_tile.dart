import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/utils/styles.dart';
import 'package:tripper/screens/widgets/tripper_button.dart';
import 'package:tripper/screens/widgets/tripper_expansion_tile.dart';

class PeopleSearchTile extends HookWidget {
  const PeopleSearchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useExpansionTileController();
    final isPeopleSet = useValueNotifier(false);

    final numberOfAdults = useValueNotifier(1);
    final numberOfChildren = useValueNotifier(0);
    final numberOfInfants = useValueNotifier(0);

    return TripperExpansionTile(
      controller: controller,
      onExpansionChanged: (isExpanded) => isPeopleSet.value = !isExpanded,
      title: ValueListenableBuilder(
        valueListenable: isPeopleSet,
        builder: (context, isSet, _) {
          late String title;

          if (isSet) {
            title = context.l10n.home_people_adults_count(numberOfAdults.value);
            if (numberOfChildren.value > 0) {
              title += ', ${context.l10n.home_people_children_count(numberOfChildren.value)}';
            }
            if (numberOfInfants.value > 0) {
              title += ', ${context.l10n.home_people_infants_count(numberOfInfants.value)}';
            }
          } else {
            title = context.l10n.home_people_hint;
          }

          return Text(
            title,
            style: TripperStyles.labelSmall.copyWith(
              color: Theme.of(context).inputDecorationTheme.hintStyle!.color!.withOpacity(isSet ? 1 : .5),
            ),
          );
        },
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
              onPressed: () => controller.collapse(),
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
