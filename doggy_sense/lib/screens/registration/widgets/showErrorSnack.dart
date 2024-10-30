import 'package:flutter/material.dart';

void showErrorSnack(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        "사진을 다시 선택해주세요",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      action: SnackBarAction(
        label: '닫기',
        onPressed: () {
          // SnackBar를 닫을 때의 동작을 여기에 추가합니다.
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
