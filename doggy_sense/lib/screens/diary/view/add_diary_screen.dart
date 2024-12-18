import 'dart:io';
import 'dart:typed_data';

import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:doggy_sense/screens/registration/widgets/showErrorSnack.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../feed/view_model/feed_screen_view_model.dart';
import '../view_model/diary_view_model.dart';

class AddDiaryScreen extends ConsumerStatefulWidget {
  XFile? img;
  AddDiaryScreen({super.key, required this.img});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends ConsumerState<AddDiaryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _sentenceController = TextEditingController();
  XFile? pickedFile;
  String title = '';
  String sentence = '';
  String imagePath = '';

  XFile? _dogImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _dogImage = pickedFile;
        imagePath = pickedFile!.path;
      } else {
        _dogImage = null;
        imagePath = 'assets/images/dog.jpg';
      }
    });
  }

  Future<Uint8List> fileToBytes(String filePath) async {
    if (filePath.startsWith('assets/')) {
      // assets 폴더의 파일은 rootBundle로 읽어야 함
      return await rootBundle
          .load(filePath)
          .then((data) => data.buffer.asUint8List());
    } else {
      // 파일 시스템에서 읽는 경우
      final file = File(filePath);
      return await file.readAsBytes();
    }
  }

  void _onSaveTap() async {
    Uint8List imgBytes;

    if (imagePath.isEmpty) {
      imgBytes = await fileToBytes('assets/images/dog.jpg');
    } else {
      imgBytes = await fileToBytes(imagePath);
    }

    int currentTime = DateTime.now().millisecondsSinceEpoch;
    DiaryModel diary = DiaryModel(
      id: null,
      dogId: 1,
      title: _titleController.text,
      img: imgBytes,
      sentence: _sentenceController.text,
      date: currentTime,
    );
    ref.read(diaryProvider.notifier).insertDiary(diary);
    Navigator.pop(context, true);
    Navigator.pop(context, true);
    ref.refresh(feedScreenProvider);
  }

  void initImage() {
    if (widget.img != null) {
      _dogImage = widget.img;
      imagePath = _dogImage!.path;
    } else {
      _dogImage = null;
    }
  }

  @override
  void initState() {
    super.initState();
    initImage();
    _titleController.addListener(
      () {
        setState(() {
          title = _titleController.text;
        });
      },
    );
    _sentenceController.addListener(
      () {
        setState(() {
          sentence = _sentenceController.text;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEDEAE3),
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
              _onSaveTap();
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
            TextField(
              keyboardType: TextInputType.text,
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '제목',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 18),
            ),
            Gaps.v16,
            // 사진 추가 버튼
            GestureDetector(
              onTap: _pickImage,
              child: _dogImage == null
                  ? Container(
                      width: double.infinity,
                      height: 150,
                      color: const Color(0xFFF0EDE5),
                      child: const Center(
                        child: Text(
                          '사진을 추가해주세요!',
                          style: TextStyle(fontSize: 16, color: Colors.brown),
                        ),
                      ),
                    )
                  : Container(
                      width: width,
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EDE5),
                        image: DecorationImage(
                          image: FileImage(File(imagePath)),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
            ),
            Gaps.v16,
            // 내용 입력 필드
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _sentenceController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: '오늘은 무슨일이 있었나요?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
