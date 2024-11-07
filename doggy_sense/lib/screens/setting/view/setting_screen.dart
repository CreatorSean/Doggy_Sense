import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/setting/view/profile_update_screen.dart';
import 'package:doggy_sense/screens/setting/widgets/profile_widget.dart';
import 'package:doggy_sense/services/databases/models/my_pet_model.dart';
import 'package:doggy_sense/services/selected_pet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  List<String> menus = ['이용 안내', 'Q&A'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final selectedPet = ref.watch(selectedPetViewModelProvider);
    return Scaffold(
      backgroundColor: const Color(0xffEDEAE3),
      body: selectedPet.when(
        data: (MyPetModel? selectedPet) {
          return Padding(
            padding: EdgeInsets.only(
              left: width * 0.1,
              right: width * 0.1,
              top: width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                ),
                Gaps.v16,
              ],
            ),
          );
        },
        error: (error, stack) => Center(child: Text('오류 발생: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

//  Expanded(
//   child: ListView.builder(
//     itemCount: menus.length + 1,
//     itemBuilder: (context, index) {
//       if (index == 0) {
//         return const Divider(
//           thickness: 1,
//           color: Color(0XFFA2A2A2),
//         );
//       } else if (index <= menus.length) {
//         return Column(
//           children: [
//             ListTile(
//               title: Text(
//                 menus[index - 1],
//                 style: TextStyle(
//                   color: const Color(0xff5D4037),
//                   fontSize: width * 0.03,
//                 ),
//               ),
//             ),
//             const Divider(
//               thickness: 1,
//               color: Color(0XFFA2A2A2),
//             ),
//           ],
//         );
//       } else {
//         return const SizedBox();
//       }
//     },
//   ),
// ),
