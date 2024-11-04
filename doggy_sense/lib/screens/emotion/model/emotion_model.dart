import 'package:image_picker/image_picker.dart';

class EmotionModel {
  String? result;
  XFile? image;

  EmotionModel({
    required this.result,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'image': image,
    };
  }
}
