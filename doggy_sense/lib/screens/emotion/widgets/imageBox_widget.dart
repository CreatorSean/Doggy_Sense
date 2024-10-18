import 'dart:io';

import 'package:doggy_sense/screens/emotion/view_model/camera_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageboxWidget extends ConsumerWidget {
  const ImageboxWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    XFile? image = ref.watch(cameraProvider.notifier).image;
    return image != null
        ? SizedBox(
            child: Image.file(
              File(image.path),
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text('이미지 로드 실패'),
                );
              },
            ),
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
            child: const Center(
              child: Text(
                '이미지가 없습니다',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
