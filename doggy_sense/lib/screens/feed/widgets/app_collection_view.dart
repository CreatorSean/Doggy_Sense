import 'package:flutter/material.dart';
import '../model/card_model.dart';
import 'card_view.dart';

class AppCollectionView extends StatelessWidget {
  final List<CardModel> cardModels;

  const AppCollectionView({super.key, required this.cardModels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardModels.length,
      itemBuilder: (context, index) {
        return CardView(cardModel: cardModels[index]);
      },
    );
  }
}
