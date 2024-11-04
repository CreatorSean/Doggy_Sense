import 'dart:async';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'databases/database_service.dart';

class SelectedPetViewModel extends AsyncNotifier<MyPetModel?> {
  MyPetModel? selectedPet;

  //view에서 선택한 유저를 바꾸는 경우 다시 set할 때 사용.
  void setselectedPet(MyPetModel? myPet) {
    Logger().i("Change Selected User : ${myPet!.dogName} -> ${myPet.id}");
    selectedPet = myPet;
    state = AsyncData(myPet); // 상태 업데이트
  }

  //sharedpreference로 가져온 userid로 db에서 MyPetModel? 가져올 때 사용.
  Future<MyPetModel?> getSavedmyPetDB(userid) async {
    var result = await DatabaseService.getSelectedPet(userid);
    if (result.isNotEmpty) {
      selectedPet = result[0];
    }
    return selectedPet;
  }

  // db에서 다시 꺼내오지않고 여기에 저장되어 있는 selectedUser를 view에서 사용.
  MyPetModel? getselectedPet() {
    return selectedPet;
  }

  // AsyncNotifier의 build() 메서드에서 초기 상태를 비동기적으로 로드
  @override
  Future<MyPetModel?> build() async {
    state = const AsyncLoading(); // 로딩 상태 설정
    try {
      // 기본적으로 사용자가 저장되어 있는 경우 로드
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? savedmyPetId = prefs.getInt('selectedPetId') ?? 1;
      MyPetModel? myPet = await getSavedmyPetDB(savedmyPetId);
      state = AsyncData(myPet); // 성공 시 데이터 설정
      return myPet;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace); // 오류 처리
      rethrow;
    }
  }
}

final selectedPetViewModelProvider =
    AsyncNotifierProvider<SelectedPetViewModel, MyPetModel?>(() {
  return SelectedPetViewModel();
});
