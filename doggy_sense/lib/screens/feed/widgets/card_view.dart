import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:flutter/material.dart';
import '../model/card_model.dart';

class CardView extends StatelessWidget {
  final CardModel cardModel;

  const CardView({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 20,
      shadowColor: Colors.grey.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset('assets/images/dog.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cardModel.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Gaps.v8,
                Text(cardModel.subtitle,
                    style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
