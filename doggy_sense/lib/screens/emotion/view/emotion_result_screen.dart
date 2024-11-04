import 'package:doggy_sense/screens/diary/view/add_diary_screen.dart';
import 'package:doggy_sense/screens/diary/view/select_image_screen.dart';
import 'package:doggy_sense/screens/emotion/model/emotion_model.dart';
import 'package:doggy_sense/screens/emotion/widgets/imageBox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmotionResultScreen extends ConsumerWidget {
  EmotionModel? result;
  EmotionResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffEDEAE3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageboxWidget(
              img: result!.image,
            ),
            const Spacer(),
            Text(
              '신이는 ${result!.result}! 😊',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const Spacer(),
            const Text(
              '신이와 함께 한 추억을 기록으로 한 번 남겨볼까요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: width * 0.5,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddDiaryScreen(
                        img: result!.image,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2AA971),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  '추억 쓰기',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
