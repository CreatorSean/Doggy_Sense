import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDiaryScreen extends ConsumerWidget {
  const AddDiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '일기 쓰기',
          style: TextStyle(color: Colors.brown, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.brown),
            onPressed: () {
              // 완료 버튼 기능 구현 예정
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 입력 필드
            const TextField(
              decoration: InputDecoration(
                hintText: '제목',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 18),
            ),
            Gaps.v16,
            // 사진 추가 버튼
            GestureDetector(
              onTap: () {
                // 사진 추가 기능 구현 예정
              },
              child: Container(
                width: double.infinity,
                height: 150,
                color: const Color(0xFFF0EDE5),
                child: const Center(
                  child: Text(
                    '사진을 추가해주세요!',
                    style: TextStyle(fontSize: 16, color: Colors.brown),
                  ),
                ),
              ),
            ),
            Gaps.v16,
            // 내용 입력 필드
            const Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: '오늘은 무슨일이 있었나요?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
