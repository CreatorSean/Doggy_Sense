import 'dart:io';

import 'package:doggy_sense/screens/emotion/view_model/camera_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageboxWidget extends ConsumerWidget {
  XFile? img;
  ImageboxWidget({
    super.key,
    required this.img,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return img != null
        ? SizedBox(
            width: width,
            height: width * 0.9,
            child: Image.file(
              File(img!.path),
              fit: BoxFit.contain,
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
