import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: MainScaffold.routeURL,
      routes: [
        GoRoute(
          path: MainScaffold.routeURL,
          name: MainScaffold.routeName,
          pageBuilder: (context, state) => const MaterialPage(
            child: MainScaffold(),
          ),
        ),
      ],
    );
  },
);
