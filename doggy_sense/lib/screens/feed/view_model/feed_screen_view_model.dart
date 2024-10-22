import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/databases/models/diary_model.dart';

class FeedScreenViewModel extends AsyncNotifier<List<DiaryModel>> {
  List<DiaryModel> diaryModel = [];

  @override
  FutureOr<List<DiaryModel>> build() {
    return diaryModel;
  }
}
