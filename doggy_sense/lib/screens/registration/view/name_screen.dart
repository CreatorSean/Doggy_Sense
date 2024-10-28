import 'package:doggy_sense/screens/registration/view/birth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/registration_view_model.dart';

class NameScreen extends ConsumerStatefulWidget {
  static String routeURL = '/name';
  static String routeName = 'name';

  const NameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  void _onNextTap() {
    if (_username.isEmpty) return;
    ref.read(registrationForm.notifier).state = {"userName": _username};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(
      () {
        setState(() {
          _username = _usernameController.text;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF9F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '이름을 입력해주세요!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff5D4037),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xff5D4037)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(color: Color(0xff5D4037), width: 2.0),
                ),
                hintText: '이름',
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onNextTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD4B499),
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