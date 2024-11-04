import 'dart:async';
import 'package:doggy_sense/common/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'emotion_result_screen.dart';

class EmotionLoadingScreen extends ConsumerStatefulWidget {
  const EmotionLoadingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmotionLoadingScreenState();
}

class _EmotionLoadingScreenState extends ConsumerState<EmotionLoadingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _lottieContorller;
  late Timer _textTimer;
  String _loadingText = '신이의 마음을 확인하고 있어요';
  int _dotCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lottieContorller = AnimationController(vsync: this);
    _textTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
        _loadingText = '신이의 마음을 확인하고 있어요${'.' * _dotCount}';
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _lottieContorller.dispose();
    _textTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              _loadingText,
              style: const TextStyle(
                fontSize: Sizes.size24,
                color: Color(0xff5D4037),
                fontFamily: 'NotoSansKR-Medium',
                fontWeight: FontWeight.w600,
              ),
            ),
            Lottie.asset(
              'assets/lotties/dogLoading.json',
              controller: _lottieContorller,
              onLoaded: (composition) {
                _lottieContorller.duration = composition.duration;
                _lottieContorller.repeat();
              },
              width: width * 0.4,
              height: height * 0.2,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
