import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tripper/l10n/l10n_utils.dart';
import 'package:tripper/screens/home/home_screen.dart';
import 'package:tripper/screens/map/map_screen.dart';
import 'package:tripper/screens/profile/profile_screen.dart';
import 'package:tripper/screens/trips/trips_screen.dart';
import 'package:tripper/screens/utils/colors.dart';
import 'package:tripper/screens/utils/styles.dart';

class TabBarScaffold extends StatelessWidget {
  const TabBarScaffold({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedLabelStyle: TripperStyles.tabBarLabelStyle,
        unselectedLabelStyle: TripperStyles.tabBarLabelStyle.copyWith(
          color: TripperColors.of(context).textSecondary,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_rounded),
            label: context.l10n.tabBar_map,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.l10n.tabBar_home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.travel_explore_rounded),
            label: context.l10n.tabBar_trips,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: context.l10n.tabBar_profile,
          ),
        ],
        currentIndex: calculateSelectedIndex(context),
        onTap: (idx) => onItemTapped(context, idx),
      ),
    );
  }

  static int calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(MapScreen.routeName)) {
      return 0;
    }
    if (location.startsWith(HomeScreen.routeName)) {
      return 1;
    }
    if (location.startsWith(TripsScreen.routeName)) {
      return 2;
    }
    if (location.startsWith(ProfileScreen.routeName)) {
      return 3;
    }

    return 1;
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(MapScreen.routeName);
      case 1:
        context.go(HomeScreen.routeName);
      case 2:
        context.go(TripsScreen.routeName);
      case 3:
        context.go(ProfileScreen.routeName);
    }
  }
}
