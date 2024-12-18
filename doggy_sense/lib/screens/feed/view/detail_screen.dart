import 'dart:io';

import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatelessWidget {
  final DiaryModel diaryModel;

  const DetailScreen({super.key, required this.diaryModel});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffEDEAE3),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        width: width,
        height: height,
        child: Column(
          children: [
            Hero(
                tag: diaryModel.id!, // Hero 태그 설정
                child: Material(
                  type: MaterialType.transparency,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.memory(
                              width: width,
                              height: width * 0.7,
                              diaryModel.img, // img가 Uint8List일 때 사용
                              fit: BoxFit.cover,
                            ),
                            // Image.file(diaryModel.img),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.black,
                                  size: Sizes.size36, // 아이콘 크기 조절
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(diaryModel.title,
                                  style: const TextStyle(
                                      fontSize: Sizes.size32,
                                      fontWeight: FontWeight.bold)),
                              Gaps.v8,
                              Text(diaryModel.sentence,
                                  style: const TextStyle(
                                      fontSize: Sizes.size28,
                                      color: Colors.grey)),
                              Gaps.v60,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
