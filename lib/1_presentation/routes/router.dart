import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../3_domain/entities.dart';
import '../pages.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  // replaceInRouteName: 'Route',
  routes: <AutoRoute>[
    AutoRoute(page: ListsOverviewPage, initial: true),
    AutoRoute(page: ListPage),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
