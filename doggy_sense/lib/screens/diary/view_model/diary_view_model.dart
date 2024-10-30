import 'dart:async';

import 'package:doggy_sense/services/databases/database_service.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryViewModel extends AsyncNotifier<List<DiaryModel>> {
  List<DiaryModel> diaryList = [];

  Future<void> getDiaryList() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      diaryList = await DatabaseService.getDiaryListDB();
      return diaryList;
    });
  }

  Future<void> insertDiary(DiaryModel diary) async {
    await AsyncValue.guard(() async {
      await DatabaseService.insertDB(diary, "Diary");
    });
  }

  Future<void> deleteDiary(DiaryModel diary) async {
    await AsyncValue.guard(() async {
      await DatabaseService.deleteDB(diary, "Diary");
    });
    await getDiaryList();
  }

  @override
  FutureOr<List<DiaryModel>> build() async {
    await getDiaryList();
    return diaryList;
  }
}

final diaryProvider = AsyncNotifierProvider<DiaryViewModel, List<DiaryModel>>(
  () {
    return DiaryViewModel();
  },
);
