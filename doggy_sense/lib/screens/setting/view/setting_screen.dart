import 'package:doggy_sense/common/constants/gaps.dart';
import 'package:doggy_sense/screens/setting/widgets/profile_widget.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xffEDEAE3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfileWidget(),
          Gaps.v16,
          Expanded(
            child: ListView.builder(
              itemCount: menus.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Divider(
                    thickness: 1,
                    color: Color(0XFFA2A2A2),
                  );
                } else if (index <= menus.length) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          menus[index - 1],
                          style: TextStyle(
                            color: const Color(0xff5D4037),
                            fontSize: width * 0.03,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0XFFA2A2A2),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
