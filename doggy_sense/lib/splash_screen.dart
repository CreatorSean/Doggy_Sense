import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Color(0xFFFAF9F6), // 배경색 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // "우리집 댕댕이" 텍스트와 아이콘
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "우리집",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff5D4037),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "댕댕이",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff5D4037),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                // 강아지 아이콘 추가
                Icon(
                  Icons.pets,
                  size: 40,
                  color: Color(0xFFFFA726), // 노란색 강아지 아이콘
                ),
              ],
            ),
            SizedBox(height: 50),
            // 집 모양 아이콘
            Icon(
              Icons.home_outlined,
              size: 150,
              color: Color(0xff5D4037), // 갈색 집 모양 아이콘
            ),
            SizedBox(height: 20),
            // 강아지 추가로 집 옆에 놓기 (추가적인 강아지 이미지)
            Icon(
              Icons.pets,
              size: 80,
              color: Color(0xFFFFA726), // 노란색 강아지 아이콘
            ),
          ],
        ),
      ),
    );
  }
}
