import 'dart:io';

import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:doggy_sense/screens/registration/view_model/registration_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImgaeScreen extends ConsumerStatefulWidget {
  static String routeName = 'profile';
  static String routeURL = '/profile';
  const ProfileImgaeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileImgaeScreenState();
}

class _ProfileImgaeScreenState extends ConsumerState<ProfileImgaeScreen> {
  XFile? _dogImage;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _dogImage = pickedFile;
        imagePath = pickedFile.path;
      });
    } else {
      imagePath = 'assets/images/dogProfile.png';
    }
  }

  void _onNextTap() {
    if (imagePath == '') {
      imagePath = 'assets/images/dogProfile.png';
    }
    final state = ref.read(registrationForm.notifier).state;
    ref.read(registrationForm.notifier).state = {...state, "img": imagePath};
    ref.read(registrationProvider.notifier).insertMyPet(context);
    context.goNamed(MainScaffold.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF9F6),
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xffFAF9F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '신이 ♂',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff8B5E3C),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '2024.05.10 1살',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xff8B5E3C),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xffD3D3D3),
                backgroundImage:
                    _dogImage != null ? FileImage(File(_dogImage!.path)) : null,
                child: _dogImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Color(0xff8B5E3C), size: 30),
                          Text(
                            '강아지 사진',
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xff8B5E3C)),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _onNextTap();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD3A688),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  '다음으로',
                  style: TextStyle(
                    fontSize: 16.0,
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
