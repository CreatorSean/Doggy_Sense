import 'dart:async';

import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:doggy_sense/screens/registration/widgets/showErrorSnack.dart';
import 'package:doggy_sense/services/databases/database_service.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegistrationViewModel extends AsyncNotifier<MyPetModel> {
  late MyPetModel myPet;

  int getUserAge(String birth) {
    int nowYear = DateTime.now().year;
    int nowMonth = DateTime.now().month;
    int nowDay = DateTime.now().day;

    int userYear = int.parse(birth.split(".")[0]);
    int userMonth = int.parse(birth.split(".")[1]);
    int userDay = int.parse(birth.split(".")[2]);

    int userAge = nowYear - userYear;
    if (nowMonth < userMonth) {
      userAge--;
    }

    if (nowMonth == userMonth) {
      if (nowDay < userDay) {
        userAge--;
      }
    }
    return userAge;
  }

  Future<void> insertMyPet(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(registrationForm);
    final age = getUserAge(form["birth"]);
    MyPetModel firstPet = MyPetModel(
      id: null,
      dogName: form["dogName"],
      birth: form["birth"],
      gender: form["gender"],
      img: form["img"],
      age: age,
    );
    await AsyncValue.guard(() async {
      DatabaseService.insertDB(firstPet, "MyPet");
    });
    myPet = firstPet;
    context.goNamed(MainScaffold.routeName);
  }

  @override
  FutureOr<MyPetModel> build() {
    return myPet;
  }
}

final registrationForm = StateProvider((ref) => {});

final registrationProvider =
    AsyncNotifierProvider<RegistrationViewModel, MyPetModel>(() {
  return RegistrationViewModel();
});
