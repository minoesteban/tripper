import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

GoRouter curanaRouter([String? initialPath]) => GoRouter(
      navigatorKey: _navigatorKey,
      initialLocation: initialPath ?? initialRoute.path,
      routes: [],
    );

@visibleForTesting
final initialRoute = GoRoute(
  path: '/',
  builder: (ctx, state) => Container(),
);
