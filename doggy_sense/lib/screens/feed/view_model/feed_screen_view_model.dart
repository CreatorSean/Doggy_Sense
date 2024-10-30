import 'dart:async';
import 'package:doggy_sense/services/databases/database_service.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreenViewModel extends AsyncNotifier<List<DiaryModel>> {
  List<DiaryModel> diaryModel = [];

  Future<void> getDiaryDB() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      diaryModel = await DatabaseService.getDiaryListDB();
      return diaryModel;
    });
  }

  @override
  FutureOr<List<DiaryModel>> build() {
    getDiaryDB();
    return diaryModel;
  }
}

final feedScreenProvider =
    AsyncNotifierProvider<FeedScreenViewModel, List<DiaryModel>>(
  () {
    return FeedScreenViewModel();
  },
);
