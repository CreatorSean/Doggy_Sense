import 'package:doggy_sense/screens/registration/view/profile_imgae_screen.dart';
import 'package:doggy_sense/screens/registration/view_model/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderScreen extends ConsumerStatefulWidget {
  const GenderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenderScreenState();
}

class _GenderScreenState extends ConsumerState<GenderScreen> {
  int? selectedGender;

  void _onNextTap() {
    final state = ref.read(registrationForm.notifier).state;
    ref.read(registrationForm.notifier).state = {
      ...state,
      "gender": selectedGender
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileImgaeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFAF9F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '아이의 성별을 알려주세요!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff5D4037),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                        ),
                        border: Border.all(color: const Color(0xff5D4037)),
                        color: selectedGender == 0
                            ? const Color(0xff5D4037)
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          '아들내미',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: selectedGender == 0
                                ? const Color(0xffFAF9F6)
                                : const Color(0xff5D4037),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                        border: Border.all(color: const Color(0xff5D4037)),
                        color: selectedGender == 1
                            ? const Color(0xff5D4037)
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          '딸내미',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: selectedGender == 1
                                ? const Color(0xffFAF9F6)
                                : const Color(0xff5D4037),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedGender != null) {
                    _onNextTap();
                  }
                },
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
