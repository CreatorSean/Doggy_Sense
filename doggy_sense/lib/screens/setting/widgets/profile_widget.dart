import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/setting/view/profile_update_screen.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:doggy_sense/services/selected_pet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyPetModel? selectedPet =
        ref.watch(selectedPetViewModelProvider.notifier).getselectedPet();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        CircleAvatar(
          radius: width * 0.1,
          backgroundImage: MemoryImage(
            selectedPet!.img, // img가 Uint8List일 때 사용
          ),
        ),
        Gaps.h24,
        Text(
          selectedPet.dogName,
          style: TextStyle(fontSize: width * 0.05),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            final result = Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileUpdateScreen(
                  myPet: selectedPet,
                ),
              ),
            );
            if (result == true) {
              ref.refresh(selectedPetViewModelProvider);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2AA971),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text(
            '편집',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
