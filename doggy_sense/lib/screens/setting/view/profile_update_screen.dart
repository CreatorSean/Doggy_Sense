import 'dart:io';
import 'dart:typed_data';

import 'package:doggy_sense/screens/main/view/main_scaffold.dart';
import 'package:doggy_sense/screens/registration/view_model/registration_view_model.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ProfileUpdateScreen extends ConsumerStatefulWidget {
  MyPetModel myPet;

  static String routeName = 'profile';
  static String routeURL = '/profile';
  ProfileUpdateScreen({
    super.key,
    required this.myPet,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends ConsumerState<ProfileUpdateScreen> {
  XFile? _dogImage;
  String imagePath = '';
  String _username = "";

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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

  int getUserAge(String birth) {
    int nowYear = DateTime.now().year;
    int nowMonth = DateTime.now().month;
    int nowDay = DateTime.now().day;

    int userYear = int.parse(birth.split(".")[0]);
    int userMonth = int.parse(birth.split(".")[1]);
    int userDay = int.parse(birth.split(".")[2]);

    int userAge = nowYear - userYear;
    if (nowMonth < userMonth) {
      userAge--;
    }

    if (nowMonth == userMonth) {
      if (nowDay < userDay) {
        userAge--;
      }
    }
    return userAge;
  }

  Future<Uint8List> fileToBytes(String filePath) async {
    final file = File(filePath);
    return await file.readAsBytes();
  }

  void _onNextTap() async {
    Uint8List imgBytes;

    imgBytes = await fileToBytes(imagePath);
    if (imagePath == '') {
      imgBytes = await fileToBytes('assets/images/dog.jpg');
    }
    final state = ref.read(registrationForm.notifier).state;
    ref.read(registrationForm.notifier).state = {...state, "img": imgBytes};
    ref.read(registrationProvider.notifier).insertMyPet(context);
    Navigator.pop(context);
  }

  void convertUint8ListToXFile(Uint8List data) async {
    final tempDir = await getTemporaryDirectory();

    final filePath = '${tempDir.path}/${const Uuid().v4()}.jpg';

    final file = await File(filePath).writeAsBytes(data);
    setState(() {
      _dogImage = XFile(file.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.addListener(
      () {
        setState(() {
          _username = _usernameController.text;
        });
      },
    );
    _username = widget.myPet.dogName;
    convertUint8ListToXFile(widget.myPet.img);
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.read(registrationForm);
    final age = getUserAge(widget.myPet.birth);
    final gender = widget.myPet.gender == 0 ? '♂' : '♀';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(fontFamily: 'NotoSansKR-Bold'),
        ),
        backgroundColor: const Color(0xffEDEAE3),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xffEDEAE3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.myPet.dogName,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff8B5E3C),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.myPet.birth,
              style: const TextStyle(
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
                  backgroundColor: const Color(0xFF2AA971),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  '수정 완료',
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
