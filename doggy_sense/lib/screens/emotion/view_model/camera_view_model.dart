import 'dart:async';
import 'package:doggy_sense/screens/emotion/view/emotion_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraViewModel extends AsyncNotifier<XFile?> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource imageSource, BuildContext context) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      image = XFile(pickedFile.path);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const EmotionLoadingScreen(),
        ),
      );
    }
  }

  @override
  FutureOr<XFile?> build() {
    return image;
  }
}

final cameraProvider = AsyncNotifierProvider<CameraViewModel, XFile?>(
  () {
    return CameraViewModel();
  },
);
