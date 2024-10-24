import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:doggy_sense/screens/registration/view/name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: NameScreen.routeURL,
      routes: [
        GoRoute(
          path: MainScaffold.routeURL,
          name: MainScaffold.routeName,
          pageBuilder: (context, state) => const MaterialPage(
            child: MainScaffold(),
          ),
        ),
        GoRoute(
          path: NameScreen.routeURL,
          name: NameScreen.routeName,
          pageBuilder: (context, state) => const MaterialPage(
            child: NameScreen(),
          ),
        ),
      ],
    );
  },
);
