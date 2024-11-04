import 'dart:io';
import 'dart:typed_data';

import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/diary/widgets/upload_image.dart';
import 'package:doggy_sense/screens/feed/view_model/upload_controller.dart';
import 'package:doggy_sense/screens/registration/widgets/showErrorSnack.dart';
import 'package:doggy_sense/services/databases/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../../common/widgets/image_data.dart';
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
    //DateTime dateTime = DateTime.now();

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

  Widget _images() {
    final uploadState = ref.watch(uploadProvider);
    final uploadNotifier = ref.read(uploadProvider.notifier);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: (uploadState.albums.isNotEmpty)
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemCount:
                    uploadState.albums[uploadState.index].images?.length ?? 0,
                itemBuilder: (context, index) {
                  final album = uploadState.albums[uploadState.index];
                  final images = album.images;

                  // Null 체크
                  if (images == null) {
                    return const SizedBox(); // 이미지가 없을 경우 빈 위젯 반환
                  }

                  return UploadImage(
                    onTap: () {
                      // 선택된 이미지를 설정
                      uploadNotifier.selectImage(images[index]);
                    },
                    entity: images[index],
                    fit: BoxFit.cover,
                  );
                },
              )
            : const Center(child: Text('텅')),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final uploadState = ref.watch(uploadProvider);
    final uploadNotifier = ref.read(uploadProvider.notifier);

    // 앨범이 비어있거나 인덱스가 유효하지 않으면 빈 위젯 반환
    if (uploadState.albums.isEmpty ||
        uploadState.index < 0 ||
        uploadState.index >= uploadState.albums.length) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // 앨범 선택 화면으로 이동
                  if (uploadState.albums.isNotEmpty) {
                    uploadNotifier.moveToChoose(context);
                  }
                },
                child: Text(
                  uploadState.albums.isNotEmpty
                      ? uploadState.albums[uploadState.index].name ?? ''
                      : '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/down_arrow_icon.jpg',
              width: 60 / MediaQuery.of(context).devicePixelRatio,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Color(0xff808080),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/image_select_icon.jpg',
                width: 60 / MediaQuery.of(context).devicePixelRatio,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Color(0xff808080),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/camera_icon.jpg',
                width: 60 / MediaQuery.of(context).devicePixelRatio,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _preview() {
    final uploadState = ref.watch(uploadProvider);
    final selectedImage = uploadState.selectedImage;

    return selectedImage != null
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: AssetEntityImage(
              selectedImage,
              isOriginal: false,
              fit: BoxFit.contain,
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          );
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
    final uploadState = ref.watch(uploadProvider);
    final selectedImage = uploadState.selectedImage;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v16,
          selectedImage != null
              ? SizedBox(
                  height: height * 0.4,
                  width: width,
                  child: AssetEntityImage(
                    selectedImage,
                    isOriginal: false,
                    fit: BoxFit.contain,
                  ),
                )
              : Container(
                  height: height * 0.4,
                  width: width,
                  color: Colors.black,
                ),
          Gaps.v16,
          _header(context),
          _images(),
        ],
      ),
    );
  }
}







          // TextField(
          //   keyboardType: TextInputType.text,
          //   controller: _titleController,
          //   decoration: const InputDecoration(
          //     hintText: '제목',
          //     hintStyle: TextStyle(color: Colors.grey),
          //     border: InputBorder.none,
          //   ),
          //   style: const TextStyle(fontSize: 18),
          // ),





          // 사진 추가 버튼
          // GestureDetector(
          //   onTap: _pickImage,
          //   child: _dogImage == null
          //       ? Container(
          //           width: double.infinity,
          //           height: height * 0.4,
          //           color: const Color(0xFFF0EDE5),
          //           child: const Center(
          //             child: Text(
          //               '사진을 추가해주세요!',
          //               style: TextStyle(fontSize: 16, color: Colors.brown),
          //             ),
          //           ),
          //         )
          //       : Container(
          //           width: double.infinity,
          //           height: height * 0.4,
          //           decoration: BoxDecoration(
          //             color: const Color(0xFFF0EDE5),
          //             image: DecorationImage(
          //               image: FileImage(File(imagePath)),
          //             ),
          //           ),
          //         ),
          // ),




          // 내용 입력 필드
          // Expanded(
          //   child: TextField(
          //     keyboardType: TextInputType.text,
          //     controller: _sentenceController,
          //     maxLines: null,
          //     expands: true,
          //     decoration: const InputDecoration(
          //       hintText: '오늘은 무슨일이 있었나요?',
          //       hintStyle: TextStyle(color: Colors.grey),
          //       border: InputBorder.none,
          //     ),
          //     style: const TextStyle(fontSize: 16),
          //   ),
          // ),