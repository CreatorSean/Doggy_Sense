import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GenderSelectionScreen(),
    );
  }
}

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFAF9F6), // Warm White background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '아이의 성별을 알려주세요!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037), // 고급스럽고 따뜻한 색감의 텍스트
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 아들내미 버튼
                GenderButton(
                  label: '아들내미',
                  icon: Icons.male, // 남성 아이콘
                  isSelected: selectedGender == '아들내미',
                  onTap: () {
                    setState(() {
                      selectedGender = '아들내미';
                    });
                  },
                ),
                const SizedBox(width: 10),
                // 딸내미 버튼
                GenderButton(
                  label: '딸내미',
                  icon: Icons.female, // 여성 아이콘
                  isSelected: selectedGender == '딸내미',
                  onTap: () {
                    setState(() {
                      selectedGender = '딸내미';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 다음으로 버튼
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4B499), // 샴페인 골드 버튼 색상
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 둥근 모서리
                ),
              ),
              child: const Text(
                '다음으로',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 성별 선택 버튼
class GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.brown[700]!, // 경계선 색상
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.brown[700],
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
