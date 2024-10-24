import 'dart:async';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreenViewModel extends AsyncNotifier<List<DiaryModel>> {
  List<DiaryModel> diaryModel = [];

  @override
  FutureOr<List<DiaryModel>> build() {
    return diaryModel;
  }
}
