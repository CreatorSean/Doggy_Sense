import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:doggy_sense/services/selected_pet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyPetModel selectedPet =
        ref.read(selectedPetViewModelProvider.notifier).getselectedPet();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CircleAvatar(
          radius: width * 0.14,
          child: Image.asset(
            selectedPet.img,
          ),
        ),
        Gaps.v24,
        Text(
          selectedPet.dogName,
          style: TextStyle(fontSize: width * 0.08),
        ),
      ],
    );
  }
}
