class CardModel {
  final String title;
  final String subtitle;
  final String description;
  final String backgroundImage;

  CardModel(
      {required this.title,
      required this.subtitle,
      required this.description,
      required this.backgroundImage});
}

class CardsData {
  static List<CardModel> cards = [
    CardModel(
      title: 'App of the Day',
      subtitle: 'Amazing app',
      description: 'This is the description of the amazing app.',
      backgroundImage: 'assets/images/app_of_the_day.jpg',
    ),
    // Add more CardModel objects here.
  ];
}
