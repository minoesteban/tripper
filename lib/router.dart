import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/auth/is_signed_in_use_case.dart';
import 'package:tripper/screens/home/home_screen.dart';
import 'package:tripper/screens/map/map_screen.dart';
import 'package:tripper/screens/profile/profile_screen.dart';
import 'package:tripper/screens/sign_in/sign_in_screen.dart';
import 'package:tripper/screens/splash/splash_screen.dart';
import 'package:tripper/screens/tab_bar/tab_bar_scaffold.dart';
import 'package:tripper/screens/trips/trips_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref, [String? initialPath]) {
  final navigatorKey = GlobalKey<NavigatorState>();

  final isSignedIn = ValueNotifier<AsyncValue<bool>>(const AsyncValue.loading());

  ref
    ..onDispose(isSignedIn.dispose)
    ..listen(isSignedInStreamProvider, (prev, next) => isSignedIn.value = next);

  final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: isSignedIn,
    initialLocation: initialPath ?? SplashScreen.routeName,
    redirect: (context, state) async {
      if (isSignedIn.value.unwrapPrevious().hasError) return SignInScreen.routeName;
      if (isSignedIn.value.isLoading || !isSignedIn.value.hasValue) return SignInScreen.routeName;

      final auth = isSignedIn.value.requireValue;

      final isSplash = state.uri.path == SplashScreen.routeName;
      if (isSplash) return auth ? HomeScreen.routeName : SignInScreen.routeName;

      final isLoggingIn = state.uri.path == SignInScreen.routeName;
      if (isLoggingIn) return auth ? HomeScreen.routeName : null;

      return auth ? null : SplashScreen.routeName;
    },
    routes: [
      splashRoute,
      signInRoute,
      tabsRouter,
    ],
  );

  ref.onDispose(router.dispose);

  return router;
}

@visibleForTesting
final splashRoute = GoRoute(
  path: SplashScreen.routeName,
  builder: (ctx, state) => const SplashScreen(),
);

@visibleForTesting
final signInRoute = GoRoute(
  path: SignInScreen.routeName,
  builder: (ctx, state) => const SignInScreen(),
);

@visibleForTesting
final tabsRouter = ShellRoute(
  builder: (context, state, child) => TabBarScaffold(child: child),
  routes: [
    mapTabRoute,
    homeTabRoute,
    profileTabRoute,
    tripsTabRoute,
  ],
);

@visibleForTesting
final mapTabRoute = GoRoute(
  path: MapScreen.routeName,
  builder: (ctx, state) => const MapScreen(),
);

@visibleForTesting
final homeTabRoute = GoRoute(
  path: HomeScreen.routeName,
  builder: (ctx, state) => const HomeScreen(),
);

@visibleForTesting
final tripsTabRoute = GoRoute(
  path: TripsScreen.routeName,
  builder: (ctx, state) => const TripsScreen(),
);

@visibleForTesting
final profileTabRoute = GoRoute(
  path: ProfileScreen.routeName,
  builder: (ctx, state) => const ProfileScreen(),
);
