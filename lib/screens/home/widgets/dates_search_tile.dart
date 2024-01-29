import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:tripper/domain/home/period_item.dart';
import 'package:tripper/domain/home/period_type.dart';
import 'package:tripper/screens/home/utils/period_item_utils.dart';
import 'package:tripper/screens/utils/exports.dart';
import 'package:tripper/screens/utils/listenable_builders.dart';
import 'package:tripper/screens/utils/styles.dart';
import 'package:tripper/screens/widgets/tripper_button.dart';
import 'package:tripper/screens/widgets/tripper_expansion_tile.dart';
import 'package:tripper/screens/widgets/tripper_selector.dart';

enum DurationType { days, weeks, months }

class DatesSearchTile extends HookWidget {
  const DatesSearchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFromDate = useValueNotifier<DateTime?>(null);
    final selectedToDate = useValueNotifier<DateTime?>(null);

    final selectedDurationType = useValueNotifier(DurationType.days);
    final selectedDuration = useValueNotifier(7);

    final selectedPeriodType = useValueNotifier(PeriodType.month);
    final selectedPeriodItems = useValueNotifier(<PeriodItem>{});

    final areDatesSelected = useValueNotifier(false);
    final isPeriodSelected = useValueNotifier(false);

    final controller = useExpansionTileController();

    useEffect(() {
      void listener() {
        if (selectedFromDate.value != null && selectedToDate.value != null) {
          areDatesSelected.value = true;
          return;
        }
        areDatesSelected.value = false;
      }

      selectedFromDate.addListener(listener);
      selectedToDate.addListener(listener);

      return () {
        selectedFromDate.removeListener(listener);
        selectedToDate.removeListener(listener);
      };
    });

    return TripperExpansionTile(
      controller: controller,
      title: ValueListenableBuilder3<bool, bool, Set<PeriodItem>>(
        notifier1: areDatesSelected,
        notifier2: isPeriodSelected,
        notifier3: selectedPeriodItems,
        builder: (context, datesSelected, periodSelected, periodItems, _) {
          late String title;
          if (datesSelected) {
            title = '${selectedFromDate.value!.asDateLong} to ${selectedToDate.value!.asDateLong}';
          } else if (periodSelected) {
            title =
                '${selectedDuration.value} ${selectedDurationType.value.name} in ${periodItems.map((item) => item.name).join(', ')}';
          } else {
            title = context.l10n.home_date_hint;
          }

          return Text(
            title,
            style: TripperStyles.labelSmall.copyWith(
              color: Theme.of(context)
                  .inputDecorationTheme
                  .hintStyle!
                  .color!
                  .withOpacity(datesSelected || periodSelected ? 1 : .5),
            ),
          );
        },
      ),
      icon: Icons.calendar_today_rounded,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.m),
            DatesRangePickerField(
              controller: controller,
              selectedFromDate: selectedFromDate,
              selectedToDate: selectedToDate,
            ),
            const OrDivider(),
            DurationTypeSelector(
              selectedDurationType: selectedDurationType,
            ),
            const SizedBox(height: Dimensions.m),
            DurationSlider(
              selectedDurationType: selectedDurationType,
              selectedDuration: selectedDuration,
            ),
            const SizedBox(height: Dimensions.m),
            Text(
              context.l10n.home_date_in,
              style: TripperStyles.labelSmall,
            ),
            const SizedBox(height: Dimensions.l),
            PeriodTypeSelector(
              selectedPeriodType: selectedPeriodType,
              selectedPeriodItems: selectedPeriodItems,
            ),
            const SizedBox(height: Dimensions.l),
            PeriodItemGrid(
              selectedPeriodType: selectedPeriodType,
              selectedFromDate: selectedFromDate,
              selectedToDate: selectedToDate,
              selectedPeriodItems: selectedPeriodItems,
            ),
            const SizedBox(height: Dimensions.xl),
            Align(
              alignment: Alignment.centerRight,
              child: ConfirmPeriodAndDurationButton(
                controller: controller,
                selectedFromDate: selectedFromDate,
                selectedToDate: selectedToDate,
                selectedPeriodItems: selectedPeriodItems,
                isPeriodSelected: isPeriodSelected,
              ),
            ),
            const SizedBox(height: Dimensions.m),
          ],
        ),
      ],
    );
  }
}

class DatesRangePickerField extends HookWidget {
  const DatesRangePickerField({
    required this.controller,
    required this.selectedFromDate,
    required this.selectedToDate,
    super.key,
  });

  final ExpansionTileController controller;
  final ValueNotifier<DateTime?> selectedFromDate;
  final ValueNotifier<DateTime?> selectedToDate;

  @override
  Widget build(BuildContext context) {
    Future<void> pickToDate() async {
      final fromDate = selectedFromDate.value;
      final toDate = selectedToDate.value;

      final selectedDate = await showDatePicker(
        context: context,
        initialDate: toDate ?? fromDate?.add(const Duration(days: 1)) ?? clock.now(),
        firstDate: fromDate?.add(const Duration(days: 1)) ?? clock.now(),
        lastDate: DateTime(2030),
      );

      if (selectedDate != null) {
        selectedToDate.value = selectedDate;
        if (selectedFromDate.value != null) {
          controller.collapse();
        }
      }
    }

    Future<void> pickFromDate() async {
      final fromDate = selectedFromDate.value;

      final selectedDate = await showDatePicker(
        context: context,
        initialDate: fromDate ?? clock.now(),
        firstDate: clock.now(),
        lastDate: DateTime(2030),
      );

      if (selectedDate != null) {
        selectedFromDate.value = selectedDate;
        if (selectedToDate.value == null) {
          unawaited(pickToDate());
        }
      }
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.m),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ValueListenableBuilder2<DateTime?, DateTime?>(
          notifier1: selectedFromDate,
          notifier2: selectedToDate,
          builder: (context, fromDate, toDate, _) => Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.sl),
                  title: Text(
                    fromDate?.asDate ?? context.l10n.home_date_from_hint,
                    style: TripperStyles.labelSmall.copyWith(
                      color: colorScheme.onBackground.withOpacity(fromDate == null ? .5 : 1),
                    ),
                  ),
                  trailing: const Icon(Icons.calendar_today_rounded),
                  onTap: pickFromDate,
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.sl),
                  title: Text(
                    toDate?.asDate ?? context.l10n.home_date_to_hint,
                    style: TripperStyles.labelSmall.copyWith(
                      color: colorScheme.onBackground.withOpacity(fromDate == null ? .5 : 1),
                    ),
                  ),
                  trailing: const Icon(Icons.calendar_today_rounded),
                  onTap: pickToDate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: Dimensions.xxl * 2,
            indent: Dimensions.xxxl,
            endIndent: Dimensions.m,
          ),
        ),
        Text(
          context.l10n.home_date_or,
          style: TripperStyles.labelSmall,
        ),
        const Expanded(
          child: Divider(
            height: Dimensions.xxl * 2,
            indent: Dimensions.m,
            endIndent: Dimensions.xxxl,
          ),
        ),
      ],
    );
  }
}

class DurationTypeSelector extends StatelessWidget {
  const DurationTypeSelector({
    required this.selectedDurationType,
    super.key,
  });

  final ValueNotifier<DurationType> selectedDurationType;

  @override
  Widget build(BuildContext context) {
    return TripperSelector<DurationType>(
      notifier: selectedDurationType,
      items: {
        DurationType.days: context.l10n.home_date_days,
        DurationType.weeks: context.l10n.home_date_weeks,
        DurationType.months: context.l10n.home_date_months,
      },
    );
  }
}

class DurationSlider extends HookWidget {
  const DurationSlider({
    required this.selectedDurationType,
    required this.selectedDuration,
    super.key,
  });

  final ValueNotifier<DurationType> selectedDurationType;
  final ValueNotifier<int> selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.m),
      child: ValueListenableBuilder2<DurationType, int>(
        notifier1: selectedDurationType,
        notifier2: selectedDuration,
        builder: (context, durationType, duration, _) {
          late double maxValue;
          switch (durationType) {
            case DurationType.days:
              maxValue = 90;

              break;
            case DurationType.weeks:
              maxValue = 12;
              break;
            case DurationType.months:
              maxValue = 3;
              break;
          }

          if (duration > maxValue) {
            duration = maxValue.truncate();
            selectedDuration.value = maxValue.truncate();
          }

          return Row(
            children: [
              Expanded(
                child: Slider(
                  value: duration.toDouble(),
                  min: 1,
                  max: maxValue,
                  divisions: maxValue.truncate() - 1,
                  onChanged: (duration) => selectedDuration.value = duration.truncate(),
                ),
              ),
              Text(
                '${duration.truncate()}',
                style: TripperStyles.labelSmall.copyWith(
                  color: Theme.of(context).buttonTheme.colorScheme!.onPrimaryContainer,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class PeriodTypeSelector extends StatelessWidget {
  const PeriodTypeSelector({
    required this.selectedPeriodType,
    required this.selectedPeriodItems,
    super.key,
  });

  final ValueNotifier<PeriodType> selectedPeriodType;
  final ValueNotifier<Set<PeriodItem>> selectedPeriodItems;

  @override
  Widget build(BuildContext context) {
    return TripperSelector<PeriodType>(
      notifier: selectedPeriodType,
      items: {
        PeriodType.month: context.l10n.home_date_month,
        PeriodType.season: context.l10n.home_date_season,
      },
      onChanged: () => selectedPeriodItems.value = {},
    );
  }
}

class PeriodItemGrid extends StatelessWidget {
  const PeriodItemGrid({
    required this.selectedPeriodType,
    required this.selectedFromDate,
    required this.selectedToDate,
    required this.selectedPeriodItems,
    super.key,
  });

  final ValueNotifier<PeriodType> selectedPeriodType;
  final ValueNotifier<DateTime?> selectedFromDate;
  final ValueNotifier<DateTime?> selectedToDate;
  final ValueNotifier<Set<PeriodItem>> selectedPeriodItems;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).buttonTheme.colorScheme;

    return ValueListenableBuilder(
      valueListenable: selectedPeriodType,
      builder: (context, periodType, child) {
        final items = List.generate(
          periodType == PeriodType.month ? 12 : 4,
          (index) => PeriodItem(value: index + 1, type: periodType),
        );

        return ValueListenableBuilder(
          valueListenable: selectedPeriodItems,
          builder: (context, selectedItems, child) {
            return GridView(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: periodType == PeriodType.month ? 3 : 2,
                mainAxisSpacing: Dimensions.m,
                crossAxisSpacing: Dimensions.m,
                childAspectRatio: 2,
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.m),
              children: [
                ...items.map(
                  (item) {
                    final isSelected = selectedItems.contains(item);

                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          selectedPeriodItems.value = selectedPeriodItems.value.difference({item});
                          return;
                        }

                        selectedPeriodItems.value = {...selectedPeriodItems.value, item};
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: isSelected ? colorScheme!.onSecondary : colorScheme!.onPrimaryContainer,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        color: isSelected ? colorScheme.onPrimaryContainer : null,
                        child: Center(
                          child: Text(
                            item.name,
                            style: TripperStyles.labelSmall.copyWith(
                              color: isSelected ? colorScheme.background : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ConfirmPeriodAndDurationButton extends StatelessWidget {
  const ConfirmPeriodAndDurationButton({
    required this.controller,
    required this.selectedFromDate,
    required this.selectedToDate,
    required this.selectedPeriodItems,
    required this.isPeriodSelected,
    super.key,
  });

  final ExpansionTileController controller;
  final ValueNotifier<DateTime?> selectedFromDate;
  final ValueNotifier<DateTime?> selectedToDate;
  final ValueNotifier<Set<PeriodItem>> selectedPeriodItems;
  final ValueNotifier<bool> isPeriodSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.m),
      child: ValueListenableBuilder(
        valueListenable: selectedPeriodItems,
        builder: (context, selectedItems, child) => TripperButton(
          text: context.l10n.home_date_confirm,
          enabled: selectedItems.isNotEmpty,
          onPressed: () {
            selectedFromDate.value = null;
            selectedToDate.value = null;

            isPeriodSelected.value = true;

            controller.collapse();
          },
        ),
      ),
    );
  }
}

extension on DateTime {
  String get asDate => DateFormat.yMd().format(this);
  String get asDateLong => DateFormat.yMMMd().format(this);
}

extension on DurationType {
  String get name {
    switch (this) {
      case DurationType.days:
        return L10n.current.home_date_days;
      case DurationType.weeks:
        return L10n.current.home_date_weeks;
      case DurationType.months:
        return L10n.current.home_date_months;
    }
  }
}
