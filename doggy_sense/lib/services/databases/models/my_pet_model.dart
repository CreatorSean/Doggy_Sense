class MyPetModel {
  final int? id;
  final int dogId;
  final String title;
  final String img;
  final String sentence;
  final int date;

  MyPetModel({
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
