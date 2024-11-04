import 'package:doggy_sense/screens/emotion/view/emotion_loading_screen.dart';
import 'package:doggy_sense/screens/emotion/view/emotion_result_screen.dart';
import 'package:doggy_sense/screens/emotion/view_model/camera_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmotionScreen extends ConsumerWidget {
  const EmotionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(cameraProvider).when(
          data: (result) => EmotionResultScreen(
            result: result,
          ),
          error: (error, stackTrace) {
            debugPrint('Error: $error\nStackTrace: $stackTrace');
            return Column(
              children: [
                const Text("An error occurred while retrieving information."),
                Text("err: $error"),
                Text("stackTrace: $stackTrace"),
              ],
            );
          },
          loading: () => const EmotionLoadingScreen(),
        );
  }
}
