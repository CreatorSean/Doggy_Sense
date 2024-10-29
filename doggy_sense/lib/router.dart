import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:doggy_sense/screens/registration/view/birth_screen.dart';
import 'package:doggy_sense/screens/registration/view/gender_screen.dart';
import 'package:doggy_sense/screens/registration/view/name_screen.dart';
import 'package:doggy_sense/screens/registration/view/profile_imgae_screen.dart';
import 'package:doggy_sense/services/databases/database_service.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: MainScaffold.routeURL,
      redirect: (context, state) async {
        List<MyPetModel> petList = [];
        petList = await DatabaseService.getPetListDB();
        print(petList[0].dogName);
        if (petList.isEmpty) {
          print("empty");
          if (state.matchedLocation == MainScaffold.routeURL) {
            print('im in main');
            return NameScreen.routeURL;
          }
        }
        return null;
      },
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
        GoRoute(
          path: BirthScreen.routeURL,
          name: BirthScreen.routeName,
          pageBuilder: (context, state) => const MaterialPage(
            child: BirthScreen(),
          ),
        ),
        GoRoute(
          path: GenderScreen.routeURL,
          name: GenderScreen.routeName,
          builder: (context, state) {
            return const GenderScreen();
          },
        ),
        GoRoute(
          path: ProfileImgaeScreen.routeURL,
          name: ProfileImgaeScreen.routeName,
          builder: (context, state) {
            return const ProfileImgaeScreen();
          },
        ),
      ],
    );
  },
);
