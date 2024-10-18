import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/card_model.dart';

class DetailScreen extends StatelessWidget {
  final CardModel cardModel;

  const DetailScreen({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF9F6),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Hero(
                tag: cardModel.title, // Hero 태그 설정
                child: Material(
                  type: MaterialType.transparency,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset('assets/images/dog.jpg'),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.black,
                                  size: Sizes.size36, // 아이콘 크기 조절
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cardModel.title,
                                  style: const TextStyle(
                                      fontSize: Sizes.size32,
                                      fontWeight: FontWeight.bold)),
                              Gaps.v8,
                              Text(cardModel.subtitle,
                                  style: const TextStyle(
                                      fontSize: Sizes.size28,
                                      color: Colors.grey)),
                              Gaps.v60,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
