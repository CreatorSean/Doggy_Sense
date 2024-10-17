import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/card_view.dart';
import '../model/card_model.dart';
import 'detail_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<CardModel> cards = CardsData.cards;
  List<Widget> diaryEntries = [];
  DateTime selectedDate = DateTime.now();
  String title = "10월의 기록";

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
  Widget build(BuildContext context) {
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Hero(
                      tag: cards[index].title, // Hero 태그 설정
                      child: CardView(cardModel: cards[index]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailScreen(cardModel: cards[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
