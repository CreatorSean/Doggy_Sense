import 'dart:io';
import 'dart:typed_data';
import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/registration/view_model/registration_view_model.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:doggy_sense/services/selected_pet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  String _dogName = "";

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _dogNameController = TextEditingController();
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
    int age = getUserAge(_dateController.text);
    if (imagePath == '') {
      imagePath = _dogImage!.path;
    }
    imgBytes = await fileToBytes(imagePath);
    if (imagePath == '') {
      imgBytes = await fileToBytes('assets/images/dog.jpg');
    }
    MyPetModel pet = MyPetModel(
      id: widget.myPet.id,
      dogName: _dogName,
      birth: _dateController.text,
      gender: widget.myPet.gender,
      img: imgBytes,
      age: age,
    );
    ref.watch(registrationProvider.notifier).updatePet(pet);
    ref.refresh(selectedPetViewModelProvider);
    Navigator.pop(context, true);
  }

  void convertUint8ListToXFile(Uint8List data) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${const Uuid().v4()}.jpg';
    final file = await File(filePath).writeAsBytes(data);
    setState(() {
      _dogImage = XFile(file.path);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime parsedDate =
        DateTime.parse(widget.myPet.birth.replaceAll('.', '-'));
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: parsedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy.MM.dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dogNameController.addListener(
      () {
        setState(() {
          _dogName = _dogNameController.text;
        });
      },
    );
    setState(() {
      _dateController.text = widget.myPet.birth;
    });
    convertUint8ListToXFile(widget.myPet.img);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'NotoSansKR-Medium',
          ),
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
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xffD3D3D3),
                    backgroundImage: _dogImage != null
                        ? FileImage(File(_dogImage!.path))
                        : null,
                    child: _dogImage == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add,
                                  color: Color(0xff8B5E3C), size: 30),
                              Text(
                                '강아지 사진',
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xff8B5E3C)),
                              ),
                            ],
                          )
                        : null,
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v40,
            Center(
              child: TextField(
                controller: _dogNameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: widget.myPet.dogName,
                  border: InputBorder.none,
                ),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Gaps.v40,
            _buildInfoRow('생년월일', widget.myPet.birth,
                func: () async => await _selectDate(context), isLink: true),
            Gaps.v40,
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

  Widget _buildInfoRow(String title, String value,
      {bool editable = true,
      bool isLink = false,
      required Future<void> Function() func}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          isLink
              ? GestureDetector(
                  onTap: () async {
                    await func();
                  },
                  child: Text(
                    _dateController.text,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Text(
                  value,
                  style: TextStyle(
                      fontSize: 16,
                      color: editable ? Colors.black : Colors.grey),
                ),
        ],
      ),
    );
  }
}
