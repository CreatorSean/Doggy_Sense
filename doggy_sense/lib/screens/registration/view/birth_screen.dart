import 'package:doggy_sense/screens/registration/view/gender_screen.dart';
import 'package:doggy_sense/screens/registration/view_model/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BirthScreen extends ConsumerStatefulWidget {
  const BirthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BirthScreenState();
}

class _BirthScreenState extends ConsumerState<BirthScreen> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy.MM.dd').format(picked);
      });
    }
  }

  void _onNextTap() {
    if (_dateController.text.isEmpty) return;
    final state = ref.read(registrationForm.notifier).state;
    ref.read(registrationForm.notifier).state = {
      ...state,
      "birth": _dateController.text
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GenderScreen(),
      ),
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
              '아이의 생일을 알려주세요!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff8B5E3C),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xff8B5E3C)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today,
                      color: Color(0xff8B5E3C)),
                  onPressed: () => _selectDate(context),
                ),
                hintText: 'YYYY.MM.DD',
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
