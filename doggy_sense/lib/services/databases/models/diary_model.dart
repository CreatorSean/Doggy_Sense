import 'dart:typed_data';

class DiaryModel {
  final int? id;
  final int dogId;
  final String title;
  final Uint8List img;
  final String sentence;
  int date;

  DiaryModel({
    required this.id,
    required this.dogId,
    required this.title,
    required this.img,
    required this.sentence,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dogId': dogId,
      'title': title,
      'img': img,
      'sentence': sentence,
      'date': date,
    };
  }
}
