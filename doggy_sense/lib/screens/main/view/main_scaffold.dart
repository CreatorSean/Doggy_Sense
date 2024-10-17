import 'package:doggy_sense/common/widgets/main_appbar.dart';
import 'package:doggy_sense/screens/emotion/view/emotion_onboarding_screen.dart';
import 'package:doggy_sense/screens/feed/view/feed_screen.dart';
import 'package:doggy_sense/screens/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScaffold extends ConsumerStatefulWidget {
  static const routeName = 'home';
  static const routeURL = '/home';

  const MainScaffold({
    super.key,
  });

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _selectedPageIndex = 0;
  String title = '';

  final List<Widget> _pageScreen = <Widget>[
    FeedScreen(),
    const EmotionOnboardingScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titleList = <String>[
      "Feed",
      "Emo",
      "Setting",
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: MainAppbar(
            title: titleList[_selectedPageIndex],
          ),
        ),
      ),
      body: _pageScreen[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffFAF9F6),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 35,
            ),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.camera,
              size: 35,
            ),
            label: 'Emo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.gear,
              size: 35,
            ),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedPageIndex, // 지정 인덱스로 이동
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped, // 선언했던 onItemTapped
      ),
    );
  }
}