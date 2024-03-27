import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tripper/domain/chat/trip.dart';
import 'package:tripper/screens/utils/exports.dart';

class TripScreen extends HookConsumerWidget {
  const TripScreen({
    required this.trip,
  });

  static const routeName = 'trip';

  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trip.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimensions.l),
              _LeftBorder(
                child: Column(
                  children: [
                    ...trip.legs.map(
                      (leg) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              leg.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Dimensions.l),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: TripperColors.brandAccent.withOpacity(.75),
                                ),
                                const SizedBox(width: Dimensions.s),
                                Text(
                                  leg.fromDate.asFullDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.s),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: TripperColors.brandAccent.withOpacity(.75),
                                ),
                                const SizedBox(width: Dimensions.s),
                                Text(
                                  leg.toDate.asFullDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.ml),
                            if (leg.places.isNotEmpty)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.place_rounded,
                                    color: TripperColors.brandAccent.withOpacity(.75),
                                  ),
                                  const SizedBox(width: Dimensions.s),
                                  Flexible(
                                    child: Text(
                                      leg.places.join(', '),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: Dimensions.ml),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ...leg.activities
                                    .map(
                                      (activity) => Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.transfer_within_a_station_sharp,
                                            size: 20,
                                            color: TripperColors.brandAccent.withOpacity(.75),
                                          ),
                                          const SizedBox(width: Dimensions.s),
                                          Expanded(
                                            child: Text(
                                              activity,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .expand(
                                      (item) => [
                                        item,
                                        const SizedBox(height: Dimensions.s),
                                      ],
                                    ),
                              ],
                            ),
                            const SizedBox(height: Dimensions.l),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.l),
              ElevatedButton(
                onPressed: context.pop,
                child: Text(context.l10n.common_back),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftBorder extends StatelessWidget {
  const _LeftBorder({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Dimensions.m),
      padding: const EdgeInsets.only(left: Dimensions.sl),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      child: child,
    );
  }
}

extension DateTimeExtensions on DateTime {
  String get asFullDate => DateFormat('EEEE, MMMM d').format(this);
}
