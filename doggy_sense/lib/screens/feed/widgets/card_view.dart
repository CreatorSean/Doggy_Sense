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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/dog.jpg'),
            Text(cardModel.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Gaps.v8,
            Text(cardModel.subtitle,
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
