import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/registration/widgets/showErrorSnack.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../view_model/diary_view_model.dart';

class AddDiaryScreen extends ConsumerStatefulWidget {
  const AddDiaryScreen({super.key});

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

  void _onSaveTap() {
    if (imagePath.isEmpty) {
      imagePath = 'assets/images/dog.jpg';
    }
    DateTime dateTime = DateTime.now();
    DiaryModel diary = DiaryModel(
      id: null,
      dogId: 1,
      title: _titleController.text,
      img: imagePath,
      sentence: _sentenceController.text,
      date: dateTime.microsecondsSinceEpoch,
    );
    ref.read(diaryProvider.notifier).insertDiary(diary);
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
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
                      width: double.infinity,
                      height: 150,
                      color: const Color(0xFFF0EDE5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
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
