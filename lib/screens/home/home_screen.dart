import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/home/widgets/dates_search_tile.dart';
import 'package:tripper/screens/home/widgets/people_search_tile.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_tile.dart';
import 'package:tripper/screens/utils/exports.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                const SizedBox(height: Dimensions.s),
                ElevatedButton(
                  child: Text(context.l10n.home_search_button),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
