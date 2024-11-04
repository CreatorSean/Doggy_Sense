import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/card_model.dart';

class CardView extends StatelessWidget {
  final DiaryModel diaryModel;

  const CardView({super.key, required this.diaryModel});

  @override
  Widget build(BuildContext context) {
    // microsecondsSinceEpoch 값을 DateTime으로 변환
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(diaryModel.date);
    print("Raw date value: $dateTime");
    String formattedDate = DateFormat('MM월 dd일').format(dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formattedDate,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v8,
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 20,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.memory(
                  diaryModel.img, // img가 Uint8List일 때 사용
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(diaryModel.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Gaps.v8,
                    Text(diaryModel.sentence,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
