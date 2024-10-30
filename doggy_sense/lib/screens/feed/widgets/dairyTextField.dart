import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:flutter/material.dart';

class DairyTextField extends StatelessWidget {
  final double width;
  final double height;

  const DairyTextField({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xff5D4037),
          width: 2,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Text(
              '오늘은 무슨 일이 있었나요?',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w400,
                fontFamily: 'NotoSansKR-Medium',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
