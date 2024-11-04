import 'dart:async';
import 'dart:io';
import 'package:doggy_sense/screens/emotion/model/emotion_model.dart';
import 'package:doggy_sense/screens/emotion/view/emotion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraViewModel extends AsyncNotifier<EmotionModel?> {
  String? emotion;
  XFile? image;
  EmotionModel? result;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(BuildContext context, bool isCamera) async {
    state = const AsyncValue.loading();

    final url = Uri.parse('http://192.168.1.46:8800/api/emotion');
    final picker = ImagePicker();
    final pickedFile = isCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택
    if (pickedFile == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmotionScreen(),
      ),
    );

    File imageFile = File(pickedFile.path);

    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType('image', 'jpg'), // 이미지 유형 설정
      ));

    final response = await request.send();

    // 응답 확인
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print('Image uploaded successfully: $responseBody');
      emotion = responseBody;
      result = EmotionModel(
        result: emotion,
        image: pickedFile,
      );
      state = AsyncValue.data(result);
    } else {
      print('Image upload failed: ${response.statusCode}');
      state = AsyncValue.error(
          "Image upload failed: ${response.statusCode}", StackTrace.current);
    }
  }

  @override
  FutureOr<EmotionModel?> build() {
    return result;
  }
}

final cameraProvider = AsyncNotifierProvider<CameraViewModel, EmotionModel?>(
  () {
    return CameraViewModel();
  },
);
