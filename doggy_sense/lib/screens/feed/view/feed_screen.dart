import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:doggy_sense/screens/diary/view/add_diary_screen.dart';
import 'package:doggy_sense/screens/diary/view_model/diary_view_model.dart';
import 'package:doggy_sense/screens/feed/model/card_model.dart';
import 'package:doggy_sense/screens/feed/view/detail_screen.dart';
import 'package:doggy_sense/screens/feed/view_model/feed_screen_view_model.dart';
import 'package:doggy_sense/screens/feed/widgets/card_view.dart';
import 'package:doggy_sense/screens/feed/widgets/dairyTextField.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final List<CardModel> cards = CardsData.cards;
  List<Widget> diaryEntries = [];
  DateTime selectedDate = DateTime.now();
  late String nowMonth;
  late String title;

  // 날짜 선택 기능
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String month = DateFormat('M월').format(selectedDate);
        title = "$month의 기록";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowMonth = DateFormat('MM월').format(selectedDate);
    title = '$nowMonth의 기록';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ref.watch(feedScreenProvider).when(
      data: (diaryList) {
        // 선택된 달에 해당하는 일기만 필터링
        List<DiaryModel> filteredDiaryList = diaryList.where((diary) {
          DateTime diaryDate = DateTime.fromMillisecondsSinceEpoch(diary.date);
          return diaryDate.year == selectedDate.year &&
              diaryDate.month == selectedDate.month;
        }).toList();
        return Scaffold(
          backgroundColor: const Color(0xffFAF9F6),
          body: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
                Gaps.v16,
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddDiaryScreen(
                          img: null,
                        ),
                      ),
                    );
                    if (result == true) {
                      // 데이터를 다시 가져오는 로직을 추가해 상태를 갱신합니다.
                      ref.refresh(feedScreenProvider);
                    }
                  },
                  child: DairyTextField(
                    width: width,
                    height: height,
                  ),
                ),
                Gaps.v16,
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredDiaryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Hero(
                          tag: filteredDiaryList[index].id!, // Hero 태그 설정
                          child: CardView(diaryModel: filteredDiaryList[index]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => DetailScreen(
                                  diaryModel: filteredDiaryList[index]),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Gaps.v32;
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        debugPrint('Error: $error\nStackTrace: $stackTrace');
        return Column(
          children: [
            const Text("An error occurred while retrieving user information."),
            Text("err: $error"),
            Text("stackTrace: $stackTrace"),
          ],
        );
      },
      loading: () {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
