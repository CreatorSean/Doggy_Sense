// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EmotionViewModel extends AsyncNotifier<String> {
//   String result = '';

//   @override
//   FutureOr<String> build() {
//     return result;
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class EmotionViewModel {
  static Future<Map<String, dynamic>> httpTest() async {
    const url = 'http://192.168.1.46:8800/send/data';
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('데이터 전송 성공');
        final data = json.decode(response.body) as Map<String, dynamic>;
        print(data);
        return data;
      } else {
        print('데이터 전송 실패: ${response.statusCode}');
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data;
      }
    } catch (e) {
      print('데이터 전송 오류: $e');
      return {'데이터 전송 오류': e};
    }
  }
}
