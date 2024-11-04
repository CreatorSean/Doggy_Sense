import 'package:doggy_sense/screens/emotion/view_model/camera_view_model.dart';
import 'package:doggy_sense/screens/emotion/view_model/emotion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EmotionOnboardingScreen extends ConsumerWidget {
  final String name = '신이';

  const EmotionOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              '$name의 속마음을 들어다 볼까요?',
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff5D4037),
                fontFamily: 'NotoSansKR-Regular',
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.watch(cameraProvider.notifier).getImage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4B499),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  '사진찍기',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
