import 'dart:typed_data';

class MyPetModel {
  final int? id;
  final String dogName;
  final String birth;
  final int gender; // 0: male, 1: female
  final Uint8List img;
  final int age;

  MyPetModel({
    required this.id,
    required this.dogName,
    required this.birth,
    required this.gender,
    required this.img,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dogName': dogName,
      'birth': birth,
      'gender': gender,
      'img': img,
      'age': age,
    };
  }
}
